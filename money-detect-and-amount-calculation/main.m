clear all ;
pkg load image;
A = imread('source.jpg');
B = rgb2gray(A);
BW = edge(B,'sobel');
imshow(BW);
row = size(BW,1);
col = size(BW,2);
last_row  = 1 ;
corners = [];
averages = [] ;
loop_counter = 1 ;
money_counter = 0 ;
while(true)
  for(i =last_row :  row)
    if(ismember(1,(BW(i,:))))
      a = i ; 
      break ;
    endif
  endfor

  for(i = a : row)
    if(!(ismember(1,BW(i,:))))
      b=i ;
      break ;
    endif
  endfor

  for(j = 1 :  col)
      if(BW(a+5,j) == 1 )
        c = j ; 
        break ;
      endif
  endfor
  j = col ;
  for(j =col : -1 : 1)
      
      if(BW(a+5,j) == 1)
        d = j ;
        break ;
      endif

  endfor
  
  corners(loop_counter)   = a ;
  corners(loop_counter+1) = b ;
  corners(loop_counter+2) = c ;
  corners(loop_counter+3) = d ;
  loop_counter = loop_counter + 4 ;
  last_row = b ;
  counter = 0 ;
  for(i = last_row : 1 : row)
    if(ismember(1,BW(i,:)) == 1)
      counter += 1 ;
    end
  endfor
  if(counter<10)
    break ;
  endif  
endwhile


temp=1;
dc  = 1 ;
for(i = 1 : 1 : size(corners,2)/4)

    new_img= A(corners(temp):corners(temp+1),corners(temp+2):corners(temp+3),:);
    temp = temp + 4 ;
    figure,imshow(new_img);
    title(i);
    row2 = size(new_img,1);
    col2 = size(new_img,2);
    new_img2  = rgb2hsv(new_img);  
    new_img2 = new_img2(:,:,1); 
    counter = 0 ;
    for(i=  1 : row2)
      
      for(j = 1 : col2)
        
        counter = counter + new_img2(i,j) ; 
      
      endfor
    
    endfor
    averages(dc) = counter/(row*col2);
    dc++ ;
endfor
for (i =  1 : 1 : size(averages,2))
    temp = averages(i);

    if (temp  > 0.08)
      money_counter = money_counter + 200;
     elseif(temp > 0.065 && temp < 0.08)  
      money_counter += 100 ;
    elseif(temp>0.012 && temp < 0.018)
      money_counter += 50 ;
    elseif(temp >0.020 && temp < 0.033)
      money_counter += 20 ;
    elseif(temp>0.034 && temp<0.056)
      money_counter += 10 ;
    else
      disp('unidentified amount of money') ;
    end
endfor

disp('total money value in the image :'+money_counter);
