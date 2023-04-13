p1={
	x=0,
	y1=24,
	y2=40,
	vel=0
}
p2={
	x=63,
	y1=10,
	y2=14,
	vel=0
}
ball={
	x=32,
	y=32,
	xvel=1,
	yvel=0.33,
	c=7,
	dampener=6,
	lastcolly=32
}


ctrl=-1
gameover=false
youwin=nil

function _update()
	if(not gameover)then
		if(ball.x<0)then
			gameover=true
			youwin=false
		elseif(ball.x>63)then
			gameover=true
			youwin=true
		end
		if(btn(⬇️))then
			p1.y1+=1
			p1.y2+=1
			p1.vel=1
		end
		
		if(btn(⬆️))then
			p1.y1-=1
			p1.y2-=1
			p1.vel=-1
		end
		
		if(not btn(⬆️) and not btn(⬇️))then
			p1.vel=0
		end
		
		if(collide("left",ball,7) or collide("right",ball,7))then
			ball.xvel*=-1
			ctrl*=-1
			if(collide("left",ball,7))then
				ball.yvel+=p1.vel/ball.dampener
			end
			ball.lastcolly=ball.y
			sfx(1)
		end
		
		if(collide("down",ball,7) or collide("up",ball,7))then
			ball.yvel*=-1
		end
		
		ball.x+=ball.xvel
		ball.y+=ball.yvel
		
		--slope intercept algorithm
		--ball.yvel/ball.xvel)*63+ball.lastcolly
		
		if(ball.y<=p2.y1 and ctrl==-1)then
			p2.y1-=1
			p2.y2-=1
			p2.vel=-1
		else
			p2.vel=0
		end
		if(ball.y>=p2.y2-1 and ctrl==-1)then
			p2.y1+=1
			p2.y2+=1
			p2.vel=1
		else
			p2.vel=0
		end	
	end
end
function _draw()
	cls()
	poke(0x5f2c,3)
	if(not gameover)then
		line(p1.x,p1.y1,p1.x,p1.y2,7)
		line(p2.x,p2.y1,p2.x,p2.y2,7)
		pset(ball.x,ball.y,ball.c)
		line(0,0,63,0,7)
		line(0,63,63,63,7)
		--show predicted collision
		--pset(62,(ball.yvel/ball.xvel)*62+ball.lastcolly,11)
	else
		if(youwin)then
			print("you won! (somehow)",0,0,7)
		else
			print("you lost!",0,0,7)
		end
	end
end
