function result = vectorCross (A_x, A_y, B_x, B_y, C_x, C_y, D_x, D_y) ;

score = ((C_x-A_x)*(B_y-A_y) - (B_x-A_x)*(C_y-A_y)) * ((D_x-A_x)*(B_y-A_y) - (B_x-A_x)*(D_y-A_y)) ;

if score > 0
    result = -1 ;
    
else
    score2 = ((A_x-C_x)*(D_y-C_y) - (D_x-C_x)*(A_y-C_y)) * ((B_x-C_x)*(D_y-C_y) - (D_x-C_x)*(B_y-C_y)) ;
    
    if score2 > 0
        result = -1 ;
        
    elseif (score < 0) && (score2 < 0)
        result = 1 ;
    
    elseif (score == 0) && (score2 < 0)
        result = 0 ;
        
    elseif (score < 0) && (score2 == 0)
        result = 0 ;
        
    elseif (A_x < C_x) && (A_x < D_x) && (B_x < C_x) && (B_x < D_x)
        result = -1 ;
        
    elseif (A_x > C_x) && (A_x > D_x) && (B_x > C_x) && (B_x > D_x)
        result = -1 ;
        
    elseif (A_y < C_y) && (A_y < D_y) && (B_y < C_y) && (B_y < D_y)
        result = -1 ;
        
    elseif (A_y > C_y) && (A_y > D_y) && (B_y > C_y) && (B_y > D_y)
        result = -1 ;
     
    else 
        result = 0 ;
        
    end

end
