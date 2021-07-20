--functions

--prijnt
function cprint(text,x,y,c)
    local len = print(text,0,-10)
    print(text,x-len/2,y,c)
end

function wprint(t,x,y,c)
    local l=split(t,"")
    for i=1,#l do
        x=print(l[i],x,y+2*sin(x/48+time()),c)
    end
end

--player
function player_update()
		--physics
		player.dy+=gravity
		player.dx*=friction
		
		--controls
		if btn(⬅️) then
		--sfx(2,2)
				player.dx-=player.acc
				player.running=true
				player.flp=true
		end
		
		if btn(➡️) then
		--sfx(2,2)
				player.dx+=player.acc
				player.running=true
				player.flp=false
		end
		
		--slide
		if player.running
		and not btn(⬅️)
		and not btn(➡️)
		and not player.falling
		and not player.jumping then
				player.running=false
				player.sliding=true
		end
		
		--jump
		if btnp(4)
		and player.landed then
		sfx(1)
				player.dy-=player.jump	
				player.landed=false
		end
		
		
		--fall through platforms
		if btn(⬇️)
		and collide_map(player,"down",7) then
		player.platform_fall=true
		else
		player.platform_fall=false
		end
		
		--check collision up and down
  if player.dy>0 then
    player.falling=true
    player.landed=false
    player.jumping=false
    
    player.dy=limit_speed(player.dy,player.max_dy)
    
  if collide_map(player,"down",0) then
    player.landed=true
    player.falling=false
    if player.platform_fall==false
    and player.landed then
    		player.dy=0
    		player.y-=((player.y+player.h+1)%8)-1
    end
    
    		--------test--------
    		collide_d="yes"
	    	else collide_d="no"
    		--------------------
  end
 elseif player.dy<0 then
    player.jumping=true
    if collide_map(player,"up",1) then
      player.dy=0
      
      
      		--------test--------
    				collide_u="yes"
    				else collide_u="no"
    				--------------------
    end
  end
  
  --check collision left and right
  if player.dx<0 then
  
  player.dx=limit_speed(player.dx,player.max_dx)
  
  		 if collide_map(player,"left",1) then
  		 player.dx=0
  		 
  		 	--------test--------
    		collide_l="yes"
    		else collide_l="no"
    		--------------------

  end
  elseif player.dx>0 then
  
  player.dx=limit_speed(player.dx,player.max_dx)

    if collide_map(player,"right",1) then
      player.dx=0
      
    				--------test--------
    				collide_r="yes"
    				else collide_r="no"
		    		--------------------

    end
  end
 
  
  --stop sliding
  if player.sliding then
    if abs(player.dx)<.2
    or player.running then
      player.dx=0
      player.sliding=false
    end
  end
		
		player.x+=player.dx
		player.y+=player.dy
		
		
end


--player animation
function player_animate()
		if player.jumping then
    player.sp=1
     player.idle=false
  elseif player.falling then
    player.sp=1
     player.idle=false
  elseif player.sliding then
    player.sp=1
     player.idle=false
  elseif player.running then
  		player.idle=false
    if time()-player.anim>.1 then
      player.anim=time()
      player.sp+=1
      if player.sp>4 then
        player.sp=1
      end
    end
  elseif btn(⬇️) then
  		player.sp=6
  else --player idle
  		player.idle=true
    player.sp=1
  end
end

--limit speed
function limit_speed(num,maximum)
  return mid(-maximum,num,maximum)
end


function testing_mode()
		testbool = not testbool
end

function player_alive()
		--kill the player
		if collide_map(player,"up",2) then
				player.alive = false
		end
		if collide_map(player,"down",2) then
				player.alive = false
		end
end

function bounce_pad()
		if collide_map(player,"down",3)
		and player.landed then
				sfx(0)
				player.dy-=(player.boost*1.3)
				player.landed=false
		end
		
		if collide_map(player,"up",3) then
				sfx(0)
				player.dy+=(player.boost*1.3)
				player.landed=false
		end
		
		if collide_map(player,"left",4) then
				sfx(0)
								player.max_dx=7
				player.dx+=(player.boost*7)		
				player.dy-=(player.boost*0.5)		
		end
		if collide_map(player,"right",4) then
				sfx(0)
				player.max_dx=7
				player.dx-=(player.boost*7)
				player.dy-=(player.boost*0.5)
		end
end


function player_sound()
		if abs(player.dx)	>= 3 then
				sfx(5,2)
		elseif abs(player.dx) >= 2 then
				sfx(4,2)
		elseif abs(player.dx) >= 1 then
				sfx(3,2)
		elseif abs(player.dx) >= 0.3 then
				sfx(2,2)
		else
				sfx(-1,2)
		end
end

-- "fa" is a number ranging from 0 to 1
-- 1 = 100% faded out
-- 0 = 0% faded out
-- 0.5 = 50% faded out, etc.

function fade_scr(fa)
	fa=max(min(1,fa),0)
	local fn=8
	local pn=15
	local fc=1/fn
	local fi=flr(fa/fc)+1
	local fades={
		{1,1,1,1,0,0,0,0},
		{2,2,2,1,1,0,0,0},
		{3,3,4,5,2,1,1,0},
		{4,4,2,2,1,1,1,0},
		{5,5,2,2,1,1,1,0},
		{6,6,13,5,2,1,1,0},
		{7,7,6,13,5,2,1,0},
		{8,8,9,4,5,2,1,0},
		{9,9,4,5,2,1,1,0},
		{10,15,9,4,5,2,1,0},
		{11,11,3,4,5,2,1,0},
		{12,12,13,5,5,2,1,0},
		{13,13,5,5,2,1,1,0},
		{14,9,9,4,5,2,1,0},
		{15,14,9,4,5,2,1,0}
	}
	
	for n=1,pn do
		pal(n,fades[n][fi],0)
	end
end

function crt_mode()
		crt=not crt
end

function slopes()
		
		if collide_map(player,"right",4) then
				player.y-=player.dx*1
		end
end



--playerboosting this was not implemented and i noticed that now
