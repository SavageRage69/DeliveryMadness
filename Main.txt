-- delivery madness
-- by savage_rage

--main

--var
blink_frame = false
t = 0
cur_col=6
cur_col2=15

startmenu=false

blink_col=5

cutscene1y = 72

title_sp=001

--custom menuy items
menuitem(1, "testing_mode", function() testing_mode() sfx(10) end)
menuitem(2, "crt", function() crt_mode() sfx(10) end)

--main_menu state
function init_menu()
--init functions here
startmenu=false
end

function update_menu()

  t = (t + 1) % 8
  blink_frame = (t == 0)
  
  if blink_frame then
    cur_col+=1
    if cur_col>14 then
    cur_col=6
    end
    
    cur_col2+=1
    if cur_col2>14 then
    cur_col2=6
    end
    
    if startmenu==true then
    blink_col+=1
    if blink_col>7 then
    blink_col=5
    end
    if blink_col>5 then
    blink_col=7
    end
    end
    
  end
  
		if btnp(🅾️) 
		or btnp(❎)
		and startmenu==false then	
		timer = time()
		startmenu=true
		end
		
		if (time() - timer) > 1
		and startmenu==true then
				--start lvl1
				init_lvl1()
				_update = update_lvl1
				_draw = draw_lvl1

		end
		
		if time()-player.anim>.1 then
      player.anim=time()
      title_sp+=1
      if title_sp>4 then
        title_sp=1
      end
    end
		
end

function draw_menu()

		cls()
		--title screen
		cprint("delivery",64,40,cur_col)
		cprint("madness",64,50,cur_col2)
		cprint("x + c",64,85,blink_col)
		cprint("a game by",64,95,blink_col)
		cprint("nicholas erd",64,102,blink_col)
		
		spr(title_sp,60,60)
		spr(64,56,68)
		spr(64,64,68)
end

init_menu()

_update = update_menu

_draw = draw_menu


function draw_lvl1()
 			cls()
rectfill(0, 0, 256, 256, 1)

 			map(0,0)
 		
 			-------backround----
 			circfill(30,30,15,10)
  
  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",cam_x+64,42,8)
						cprint("\#5press c to restart",cam_x+64,72,7)
						cprint("\#5press x for main menu",cam_x+64,79,7)
				end
				
				--wprint("c m l t  t e  e i e y ",20,59, 7)
				--wprint(" o p e e  h  d l v r !",20,59, 7)
				wprint("complete the delivery!",20,59, 7)

				--------print cutscene blocks--
				spr(65,224,cutscene1y)
				spr(80,224,cutscene1y+8)
				spr(80,224,cutscene1y+16)
				spr(80,224,cutscene1y+24)
				spr(80,224,cutscene1y+32)
				spr(80,224,cutscene1y+40)
				spr(81,224,cutscene1y+48)
				
				spr(64,232,cutscene1y)
				spr(80,232,cutscene1y+8)
				spr(81,232,cutscene1y+16)
				spr(80,232,cutscene1y+24)
				spr(80,232,cutscene1y+32)
				spr(80,232,cutscene1y+40)
				spr(81,232,cutscene1y+48)
				-------------------------
				
				--timer
				draw_timer()
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
 -------------------
end

function init_lvl1()
-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=8
   player.y=112

   player.flp=false
   player.dx=0
   player.dy=0
   
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=0
   
------------------------------
--map limits
 map_start=0
 map_end=256 //384
 cam_start=0
 cam_end=256 //320
 
 ----
 trueblvl1=true
switchlvl1tomeny=true

cutscene1y = 72

cam_y=0
------

game_timer_start=time()
end


---cutscene--
trueblvl1=true
switchlvl1tomeny=true
-------------
function update_lvl1()

update_timer()
--------trail--------
local trail_x=player.x

if player.flp==true then
trail_x+=5
else
trail_x+=1
end

add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  deli(pos, 1)
 end
 
---------------------

		if player.alive then
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		slopes()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  		if cam_x<map_start then
     	cam_x=map_start
  	end
  		if cam_x>map_end-128 then
   		 cam_x=map_end-128
  		end
  		camera(cam_x,cam_y)
  		-----------------
 			
 			--limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
    player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl1()
					_update = update_lvl1
					_draw = draw_lvl1
				end
		end
		
		--------cutcen----------
	
if player.x >= 224 then
		if trueblvl1==true then
				sfx(6)
				trueblvl1=false
		end
		
		cutscene1y +=3
end


if player.y >= 130 then
scr_fade+=0.05
fade_scr(scr_fade)
if scr_fade>=1.5 then
  --start the lvl2
  init_lvl2()
		_update = update_lvl2
		_draw = draw_lvl2
end
end

		------------------------
end




-------lvl2------------
function init_lvl2()
-------------trail-----------
		pos = {}
--------reset player--------
			player.sp=1
   player.x=264
   player.y=8
   player.w=8
   player.h=8
   player.flp=false
   player.dx=0
   player.dy=0
   player.max_dx=3
   player.max_dy=4
   player.acc=0.5
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=true
   player.sliding=false
   player.landed=false
   player.alive=true
   
   haslanded=false
haslandedsoundbool=true
------------------------------
--map limits
 map_start=256
 map_end=512 //384
 cam_start=256
 cam_end=448 //320
 
 
  scr_fade=1
  
  
end
----------------------
haslanded=false
haslandedsoundbool=true

function update_lvl2()

update_timer()

if player.falling==false then
haslanded=true
end

if haslanded==true
and haslandedsoundbool==true then
sfx(7)
haslandedsoundbool=false
end

if haslanded==false then
scr_fade-=0.05
fade_scr(scr_fade)
		if scr_fade<=0 then
				player.x=264
				player.dy=6
		end
end
		
--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
				
  			player_update()
  			player_animate()
  			player_alive()
  			player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end

  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl2()
					_update = update_lvl2
					_draw = draw_lvl2
				end
		end
		----------------------------
		if player.x >= 500 then
		scr_fade+=0.1
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
					init_lvl3()
					_update = update_lvl3
					_draw = draw_lvl3
			end
		end
end


----------------------

function draw_lvl2()
 			cls()
		rectfill(256, 0, 384, 384, 0)

		------draw pipes-------
		spr(112, 312,120)
		spr(112, 336,120)
		spr(112, 360,120)
		spr(112, 376,120)
		spr(112, 416,120)
		spr(112, 432,120)
		-----------------------
		
 	map(0,0)
 	
 	
 	print("noo! i lost the package",265,50,7)
 	
 	draw_timer()
  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",cam_x+64,42,8)
						cprint("\#5press c to restart",cam_x+64,72,7)
						cprint("\#5press x for main menu",cam_x+64,79,7)
				end
 
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
 -------------------
end

----------------------

--lvl3
function init_lvl3()
-------------trail-----------
		pos = {}
--------reset player--------
			player.sp=1
   player.x=520
   player.y=88
   player.w=8
   player.h=8
   player.flp=false
   player.dx=0
   player.dy=0
   player.max_dx=3
   player.max_dy=4
   player.acc=0.5
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
------------------------------
--map limits
 map_start=512
 map_end=1024 //384
 cam_start=512
 cam_end=960 //320
 
 
  scr_fade=1
  
  --barf
  barf_fallx=480
  
  
  lvl3complete=false
  barf_fall_start=false
  
		lvl3word1=false
		lvl3word2=false
		lvl3word3=false
		lvl3wordcomplete=false
		
		lvl3screenfade=true
  
  timer=time()
end

function update_lvl3()
update_timer()
if lvl3screenfade==true then
scr_fade-=0.05
fade_scr(scr_fade)
if scr_fade<=0 then
lvl3screenfade=false
scr_fade=0
end 
end

if lvl3complete==false
and barf_fall_start==true
and player.alive==true then
barf_fallx+=1
end

if player.x <= barf_fallx+4 then
		player.alive = false
end
--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

if btnp(4)
and barf_fall_start==false then
		barf_fall_start=true
elseif barf_fall_start==false then
		sfx(-1, 0)
		--sfx(-1, 1)
		sfx(-1, 2)
		sfx(-1, 3)
end


---------------------

		if player.alive then
		
				if barf_fall_start==true then
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		end
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	if cam_x<barf_fallx-8 then
   		 cam_x=barf_fallx-8
  	end
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl3()
					_update = update_lvl3
					_draw = draw_lvl3
				end
		end
		-----------beat lvl3--------
		if player.y>=120 then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl4
		 init_lvl4()
		_update = update_lvl4
		_draw = draw_lvl4
		end
		end

end

function draw_lvl3()
				cls()

 			map(0,0)
 			
 			--draw water
 			spr(134,512,96)
 			spr(134,520,96)
 			spr(134,528,96)
 			spr(134,536,96)
 			
 			--draw barf_fall
 			
 			--wave1
 			spr(138,barf_fallx-8,32)
 			spr(154,barf_fallx-8,40)
 			spr(154,barf_fallx-8,48)
 			spr(154,barf_fallx-8,56)
 			spr(154,barf_fallx-8,64)
 			spr(154,barf_fallx-8,72)
 			spr(154,barf_fallx-8,80)
 			spr(154,barf_fallx-8,88)
 			spr(154,barf_fallx-8,96)
 			spr(154,barf_fallx-8,104)
 			
 			--wave2
 			spr(138,barf_fallx,40)
 			spr(154,barf_fallx,48)
 			spr(154,barf_fallx,56)
 			spr(154,barf_fallx,64)
 			spr(154,barf_fallx,72)
 			spr(154,barf_fallx,80)
 			spr(154,barf_fallx,88)
 			spr(154,barf_fallx,96)
 			spr(154,barf_fallx,104)
 			
 			cprint("a",barf_fallx,50,3)
 			cprint("c",barf_fallx,60,3)
 			cprint("i",barf_fallx,70,3)
 			cprint("d",barf_fallx,80,3)
 			
 			--draw dialog
 			if barf_fall_start==false then
 					rectfill(512, 99, 639, 126,1)
 					rect(512, 99, 639, 126, 7)
 					
 					--type out text
 					if (time() - timer) > 0 then
 					print(".",520,105, 7)
 							if lvl3word1==false then
 									sfx(8,1)
 									lvl3word1=true
 							end
 					end
 					
 					if (time() - timer) > 0.4 then
 					print(".",523,105, 7)
 							if lvl3word2==false then
 									sfx(8,1)
 									lvl3word2=true
 							end
 					end
 					
 					if (time() - timer) > 0.8 then
 					print(".",526,105, 7)
 							if lvl3word3==false then
 									sfx(8,1)
 									lvl3word3=true
 							end
 					end
  		end
  		
  		
  		draw_timer()
  -----------------------------
 			
 			if player.alive==false then
												cprint("\#5wasted",cam_x+64,42,8)
						cprint("\#5press c to restart",cam_x+64,72,7)
						cprint("\#5press x for main menu",cam_x+64,79,7)
				end
 
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
 -------------------
end


-----lvl 4
function init_lvl4()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=12
   player.y=240
   player.w=8
   player.h=8
   player.flp=false
   player.dx=0
   player.dy=0
   player.max_dx=3
   player.max_dy=4
   player.acc=0.5
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=0
 map_end=128 //384
 cam_start=0
 cam_end=64 //320
 
 cam_y=128
 
 lvl4screenfade=true
 
end

function draw_lvl4()
		 			cls()
rectfill(0, 128, 256, 256, 0)

 			map(0,0)

  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",64,170,8)
						cprint("\#5press c to restart",64,200,7)
						cprint("\#5press x for main menu",64,207,7)
				end
				
				draw_timer()

				cprint("⬇️",70,219,8)
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
end

function update_lvl4()
update_timer()
if lvl4screenfade == true then
scr_fade-=0.05
fade_scr(scr_fade)
if scr_fade<=0 then
lvl4screenfade=false
scr_fade=0
end
end


--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl4()
					_update = update_lvl4
					_draw = draw_lvl4
				end
		end
		-----------die in void--------
		if player.y>=256 then
		 player.alive=false
		end
		
		--beat lvl4
		if player.x<=4 then
				scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl5
		 init_lvl5()
		_update = update_lvl5
		_draw = draw_lvl5
		end
		end
end

--level 5

function init_lvl5()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=250
   player.y=240
   player.flp=false
   player.dx=0
   player.dy=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=128
 map_end=256 //384
 cam_start=128
 cam_end=192 //320
 
 screenfadelvl5=true
 
 beatlvl5=false
 
end

function draw_lvl5()
cls()
rectfill(0, 128, 256, 256, 0)

 			map(0,0)

  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",192,170,8)
						cprint("\#5press c to restart",192,200,7)
						cprint("\#5press x for main menu",192,207,7)
				end
				
				draw_timer()
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
end


function update_lvl5()

update_timer()

if screenfadelvl5==true then
		scr_fade-=0.05
		fade_scr(scr_fade)
		if scr_fade<=0 then
		screenfadelvl5=false
		scr_fade=0
		end
end

--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl5()
					_update = update_lvl5
					_draw = draw_lvl5
				end
		end
		-----------die in void--------
		if player.y>=256 then
		 player.alive=false
		end
		
		if player.y<=133 then
				beatlvl5=true
		end
		
		if beatlvl5==true then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl6
		 init_lvl6()
		 _draw = draw_lvl6
		 _update = update_lvl6
		end
		end
end


// lvl6

function init_lvl6()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=360
   player.y=240
   player.w=8
   player.h=8
   player.flp=false
   player.dx=0
   player.dy=0
   player.max_dx=3
   player.max_dy=4
   player.acc=0.5
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=256
 map_end=384 //384
 cam_start=256
 cam_end=320 //320
 
 screenfadelvl5=true
 
 beatlvl5=false
end

function draw_lvl6()
cls()

 			map(0,0)

  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",320,170,8)
						cprint("\#5press c to restart",320,200,7)
						cprint("\#5press x for main menu",320,207,7)
				end
				
				
				draw_timer()
				
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
end

function update_lvl6()

update_timer()

if screenfadelvl5==true then
		scr_fade-=0.05
		fade_scr(scr_fade)
		if scr_fade<=0 then
		screenfadelvl5=false
		scr_fade=0
		end
end

--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl6()
					_update = update_lvl6
					_draw = draw_lvl6
				end
		end
		-----------die in void--------
		if player.y>=256 then
		 player.alive=false
		end
		
		--beat lvl6
		if player.y<=133 then
				beatlvl5=true
		end
		
		if beatlvl5==true then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl7
		 init_lvl7()
		 _draw=draw_lvl7
		 _update=update_lvl7
		end
		end
		
end

//lvl7 

function init_lvl7()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=395
   player.y=200
   player.w=8
   player.h=8
   player.flp=false
   player.dx=0
   player.dy=0
   player.max_dx=3
   player.max_dy=4
   player.acc=0.5
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=384
 map_end=512 //384
 cam_start=384
 cam_end=448 //320
 
 screenfadelvl5=true
 
 beatlvl5=false
 
 lvl7boxy=168
 lvl7boxgrab=false
end


function draw_lvl7()
		cls()

 			map(0,0)
 			
 			spr(157, 480, lvl7boxy, 16,16)

				cprint("jump!", 460, 220, 8)
  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",448,170,8)
						cprint("\#5press c to restart",448,200,7)
						cprint("\#5press x for main menu",448,207,7)
				end
				
				draw_timer()
				
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
end

function update_lvl7()
update_timer()
if screenfadelvl5==true then
		scr_fade-=0.05
		fade_scr(scr_fade)
		if scr_fade<=0 then
		screenfadelvl5=false
		scr_fade=0
		end
end

if player.x>=460 then
lvl7boxgrab=true
end

if lvl7boxgrab then
		lvl7boxy-=4
end

--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl7()
					_update = update_lvl7
					_draw = draw_lvl7
				end
		end
		
		--beat lvl7
		if player.y>=256 then
				beatlvl5=true
		end
		
		if beatlvl5==true then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl8
		 init_lvl8()
		 _draw=draw_lvl8
		 _update=update_lvl8
		end
		end
		
end


--lvl8

function init_lvl8()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=520
   player.y=240
   player.w=8
   player.h=8
   player.flp=false
   player.dx=0
   player.dy=0
   player.max_dx=3
   player.max_dy=4
   player.acc=0.5
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=512
 map_end=640 //384
 cam_start=512
 cam_end=576 //320
 
 screenfadelvl5=true
 
 beatlvl5=false
 
 lvl7boxy=140
 lvl7boxgrab=false
end


function draw_lvl8()
		cls()

 			map(0,0)
 			
 			spr(157, 524, lvl7boxy, 16,16)


				cprint("get it!", 590, 145, 8)
  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",576,170,8)
						cprint("\#5press c to restart",576,200,7)
						cprint("\#5press x for main menu",576,207,7)
				end
				
				draw_timer()
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
end

function update_lvl8()
update_timer()
if screenfadelvl5==true then
		scr_fade-=0.05
		fade_scr(scr_fade)
		if scr_fade<=0 then
		screenfadelvl5=false
		scr_fade=0
		end
end

if player.y<=160 then
lvl7boxgrab=true
end

if lvl7boxgrab then
		lvl7boxy-=5
end

--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl8()
					_update = update_lvl8
					_draw = draw_lvl8
				end
		end
		
		--beat lvl8
		if player.y<=130 then
				beatlvl5=true
		end
		
		if beatlvl5==true then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl9
		 init_lvl9()
		 _draw=draw_lvl9
		 _update=update_lvl9
		end
		end
		
end

--lvl9

function init_lvl9()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=650
   player.y=144
   player.w=8
   player.h=8
   player.flp=false
   player.dx=0
   player.dy=0
   player.max_dx=3
   player.max_dy=4
   player.acc=0.5
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=640
 map_end=768 //384
 cam_start=640
 cam_end=704 //320
 
 screenfadelvl5=true
 
 beatlvl5=false
 
 lvl7boxy=232
 lvl7boxgrab=false
end


function draw_lvl9()
		cls()

 			map(0,0)
 			
 			spr(157, 744, lvl7boxy, 16,16)


				cprint("get it!", 590, 145, 8)
  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",704,170,8)
						cprint("\#5press c to restart",704,200,7)
						cprint("\#5press x for main menu",704,207,7)
				end
				
				draw_timer()
				
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
end

function update_lvl9()
update_timer()
if screenfadelvl5==true then
		scr_fade-=0.05
		fade_scr(scr_fade)
		if scr_fade<=0 then
		screenfadelvl5=false
		scr_fade=0
		end
end

if player.y>=215
and player.x>=740 then
lvl7boxgrab=true
end

if lvl7boxgrab then
		lvl7boxy+=5
end

--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl9()
					_update = update_lvl9
					_draw = draw_lvl9
				end
		end
		
		--beat lvl9
		if player.y>=245 then
				beatlvl5=true
		end
		
		if beatlvl5==true then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl10
		 init_lvl10()
		 _draw=draw_lvl10
		 _update=update_lvl10
		end
		end
		
end

--lvl 10
function init_lvl10()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=778
   player.y=240
   player.w=8
   player.h=8
   player.flp=false
   player.dx=0
   player.dy=0
   player.max_dx=3
   player.max_dy=4
   player.acc=0.5
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=768
 map_end=1024 //384
 cam_start=768
 cam_end=960 //320
 
 screenfadelvl5=true
 
 beatlvl5=false
 
 lvl7boxy=150
 lvl7boxgrab=false
end


function draw_lvl10()
		cls()

 			map(0,0)
 			
 			if lvl7boxgrab==false then
 					spr(157, 995, lvl7boxy, 16,16)
				end

  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",cam_x+64,170,8)
						cprint("\#5press c to restart",cam_x+64,200,7)
						cprint("\#5press x for main menu",cam_x+64,207,7)
				end
				
				draw_timer()
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
 
 if lvl7boxgrab==true then
		
		cprint("you got it!",970,150,8)
		end
end

function update_lvl10()
update_timer()
if screenfadelvl5==true then
		scr_fade-=0.05
		fade_scr(scr_fade)
		if scr_fade<=0 then
		screenfadelvl5=false
		scr_fade=0
		end
end

if player.y<=150
and player.x>=995 then
lvl7boxgrab=true
end


--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl10()
					_update = update_lvl10
					_draw = draw_lvl10
				end
		end
		
		--beat lvl10
		if player.y<=120 then
				beatlvl5=true
		end
		
		if beatlvl5==true then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl11 --lvl11 is a reverse lvl
		 init_lvl11()
		 _draw=draw_lvl11
		 _update=update_lvl11
		end
		end
		
		if lvl7boxgrab==true then
		player.dy=0
		player.dx=0
		player.y-=1
		
		cprint("you got it!",970,150,8)
		end
		
end

--lvl11
function init_lvl11()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=980
   player.y=48
   player.w=8
   player.h=8
   player.flp=true
   player.dx=0
   player.dy=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=512
 map_end=1024 //384
 cam_start=512
 cam_end=960 //320
 
 screenfadelvl5=true
 
 beatlvl5=false
 
 lvl7boxy=150
 lvl7boxgrab=false
 
 cam_y=0
end


function draw_lvl11()
		cls()

 			map(0,0)

  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",cam_x+64,42,8)
						cprint("\#5press c to restart",cam_x+64,72,7)
						cprint("\#5press x for main menu",cam_x+64,79,7)
				end
				
				draw_timer()
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
 
end

function update_lvl11()
update_timer()
if screenfadelvl5==true then
		scr_fade-=0.05
		fade_scr(scr_fade)
		if scr_fade<=0 then
		screenfadelvl5=false
		scr_fade=0
		end
end


--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl11()
					_update = update_lvl11
					_draw = draw_lvl11
				end
		end
		
		--beat lvl11
		if player.x<=512 then
				beatlvl5=true
		end
		
		if beatlvl5==true then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl12 --lvl12 is a reverse lvl
		 init_lvl12()
		 _draw=draw_lvl12
		 _update=update_lvl12
		end
		end
		
		
end

--lvl12

function init_lvl12()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=500
   player.y=90
   player.w=8
   player.h=8
   player.flp=true
   player.dx=0
   player.dy=0
   player.max_dx=3
   player.max_dy=4
   player.acc=0.5
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=256
 map_end=512 //384
 cam_start=256
 cam_end=448 //320
 
 screenfadelvl5=true
 
 beatlvl5=false
 
 lvl7boxy=150
 lvl7boxgrab=false
end


function draw_lvl12()
		cls()

 			map(0,0)

  -----------------------------
 			
 			if player.alive==false then
												cprint("\#5wasted",cam_x+64,42,8)
						cprint("\#5press c to restart",cam_x+64,72,7)
						cprint("\#5press x for main menu",cam_x+64,79,7)
				end
				
				draw_timer()
				
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
 
end

function update_lvl12()
update_timer()
if screenfadelvl5==true then
		scr_fade-=0.05
		fade_scr(scr_fade)
		if scr_fade<=0 then
		screenfadelvl5=false
		scr_fade=0
		end
end


--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl12()
					_update = update_lvl12
					_draw = draw_lvl12
				end
		end
		
		--beat lvl11
		if player.x<=264 then
		player.dy=0
		player.dx=0
				player.y-=2
				if player.y<=0 then
				beatlvl5=true
				end
		end
		
		if beatlvl5==true then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --startlvl12 --lvl12 is a reverse lvl
		 init_lvl14()
		 _draw=draw_lvl14
		 _update=update_lvl14
		end
		end
		
		
end

--lvl14
function init_lvl14()
		-------------trail-----------
pos = {}
----------------------
--------reset player--------
			player.sp=1
   player.x=8
   player.y=112
   player.flp=false
   player.dx=0
   player.dy=0
   player.boost=4
   player.anim=0
   player.running=false
   player.jumping=false
   player.falling=false
   player.sliding=false
   player.landed=false
   player.alive=true
   
   scr_fade=1
   
------------------------------
--map limits
 map_start=0
 map_end=256 //384
 cam_start=0
 cam_end=192 //320
 
 screenfadelvl5=true
 
 beatlvl5=false
 
 lvl7boxy=150
 lvl7boxgrab=false
end


function draw_lvl14()
		cls()
		
		rectfill(0, 0, 256, 256, 1)
		
		-------backround----
 			circfill(30,30,15,10)
  

 			map(0,0)

  -----------------------------
 			
 			if player.alive==false then
						cprint("\#5wasted",cam_x+64,42,8)
						cprint("\#5press c to restart",cam_x+64,72,7)
						cprint("\#5press x for main menu",cam_x+64,79,7)
				end
				
				draw_timer()
				
 ------trail----------------
 if player.idle==false then
 		for dot in all(pos) do
  		circfill(dot[1], dot[2], 1, 7)
 		end
 end
 -----------------------------
 ---------draw player-------
 spr(player.sp,
 			player.x,
 			player.y,
 			1,1,
 			player.flp)
 -------test--------
 if testbool then
 		rect(x1r,y1r,x2r,y2r, 7)
 		print("⬅️= "..collide_l,player.x,player.y-10)
 		print("➡️= "..collide_r,player.x,player.y-16)
 		print("⬆️= "..collide_u,player.x,player.y-22)
 		print("⬇️= "..collide_d,player.x,player.y-28)
 end
 
end

function update_lvl14()
update_timer()
if screenfadelvl5==true then
		scr_fade-=0.05
		fade_scr(scr_fade)
		if scr_fade<=0 then
		screenfadelvl5=false
		scr_fade=0
		end
end


--------trail--------
local trail_x=player.x

if player.flp==true then
		trail_x+=5
else
		trail_x+=1
end

		add(pos, {trail_x,player.y+5})

 if #pos > 4 then
  	deli(pos, 1)
 end
 
---------------------

		if player.alive then
		
				
  		player_update()
  		player_animate()
  		player_alive()
  		player_sound()
  		
  		bounce_pad()

 		---	simple_camera()
 		cam_x=player.x-64+(player.w/2)
  	if cam_x<cam_start then
     	cam_x=cam_start
  	end
  	if cam_x>cam_end-64 then
   		 cam_x=cam_end-64
  	end
  	
  	
  		--camera(cam_x,0)
  		camera(cam_x,cam_y)
  		-----------------
 			
 		--	limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
  		player.x=map_end-player.w
  end
  -----------------------------
		end
		
		if player.alive==false then
				if btnp(❎) then
					init_menu()
					_update = update_menu
					_draw = draw_menu
					reset()
				end
		end
		
		if player.alive==false then
				if btnp(🅾️) then
					init_lvl14()
					_update = update_lvl14
					_draw = draw_lvl14
				end
		end
		
		--beat lvl11
		if player.x>=192 then
		player.dy=0
		player.dx=0
				beatlvl5=true
		end
		
		if beatlvl5==true then
		scr_fade+=0.05
		fade_scr(scr_fade)
		if scr_fade>=1.5 then
		 --roll credits
		 init_credits()
		 _update = update_credits
		 _draw = draw_credits
		end
		end
		
		
end



function init_credits()
scr_fade=0
fade_scr(scr_fade)
end

function update_credits()
camera(0,0)

if btnp(❎) then
init_menu()
_update = update_menu
_draw = draw_menu
reset()
end

end

function draw_credits()
		cls()
		
		cprint("thanks for playing!",64,20,8)
		cprint("credits;",64,40,7)
		cprint("everything was made by me",64,47,7)
		cprint("special thx to;",64,67,7)
		cprint("atlastic 8",64,74,8)
		cprint("for play-testing!",64,81,7)
		cprint("press x for main menu!",64,100,8)
		cprint("your time was;"..game_timer,64,118,12)
end

