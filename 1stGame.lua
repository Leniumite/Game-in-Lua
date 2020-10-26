-- title:  game title
-- author: game developer
-- desc:   short description
-- script: lua

barre = {}
barre.x = 104
barre.y = 133
barre.largeur = 50
barre.hauteur = 2

balle = {}
balle.x = 125
balle.y = 64
balle.largeur = 8
balle.hauteur = 8
balle.speedY = 1
balle.speedX = math.random(-1, 1)
balle.collision = false

bloc = {}
bloc.largeur = 20
bloc.hauteur = 15

listeBlocks = {}


function difficultyUp(largeur)

	if(time()/1000 == i) then
		largeur = largeur - 5
		i = i + 10
	end		
	
	return largeur
	
end


--[[function toucheOu(x1,y1,w1,h1, x2,y2,w2,h2)
	if(x1<=x2+w2 and (y1 <= y2+h2 and	y1+h1 >= y2)) then
		return droite
	end
	
	if(x1+w1>=x2 and (y1 <= y2+h2 and	y1+h1 >= y2)) then
		return gauche
	end
	
	if(y1<=y2+h2 and (x1 <= x2+w2 and	x1+w1 >= x2)) then
		return bas
	end
	
	if(y1+h1>=y2 and (x1 <= x2+w2 and	x1+w1 >= x2)) then
		return haut
	end
end]]


function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return y1 <= y2+h2 and
									y1+h1 >= y2 and
									x1 <= x2+w2 and
									x1+w1 >= x2
end


-- On dessine 5 blocs a la suite
function creerNiveau()
	for i = 1,6 do 
		local bloc = {}
		bloc.x = 30*i
		bloc.y = 20
		bloc.largeur = 20
		bloc.hauteur = 20
		
		rect(bloc.x, bloc.y, bloc.largeur, bloc.hauteur, 4)
		
		table.insert(listeBlocks, bloc)
	end
end


function caTouche()

-- Si la balle touche la barre, ca rebondis	
	if(balle.y + balle.hauteur >= barre.y) then
		if((balle.x + balle.largeur > barre.x) and (balle.x) < (barre.x + barre.largeur)) then
			balle.speedY = -balle.speedY
		end
	end

-- Si la balle tape les cotes, on repart	
	if(balle.x > 231 or balle.x < 0) then
		balle.speedX = -balle.speedX
	end

-- Si la balle sort au dessus, on va dans l'autre sens	
	if(balle.y < 0) then
		balle.speedY = -balle.speedY
	end
	
-- Si ca sort en dessous, on perd
-- Bon c'est pas encore fou, mais ca marche	
	if(balle.y > 135) then
		exit()
	end
	
end


i = 10

function TIC()
	cls(0)
	
	rect(barre.x, barre.y, barre.largeur, barre.hauteur, 10)
	rect(balle.x, balle.y, balle.largeur, balle.hauteur, 13)
	
	-- Mouvement barre ON NE TOUCHE PLUS
	if key(04) then
		if (barre.x <= 189) then
	 	barre.x = barre.x + 1.5
		end
 end
	
	if key(17) then
		if (barre.x >= 0) then 
			barre.x = barre.x - 1.5
		end
	end
	
--	Vitesse balle
	balle.y = balle.y + balle.speedY
	balle.x = balle.x + balle.speedX	
	
-- Collisions avec la barre et l'ecran
	caTouche()
	
	creerNiveau()
	
-- ensuite on essaie de regarder si ca touche un bloc
	for i = #listeBlocks, 1, -1 do
		if(CheckCollision(balle.x + 1, balle.y + 1, balle.largeur, balle.hauteur, listeBlocks[i].x, listeBlocks[i].y, listeBlocks[i].largeur, listeBlocks[i].hauteur)) then
			if((listeBlocks[i].x<balle.x and balle.x<listeBlocks[i].x+listeBlocks[i].largeur) or (listeBlocks[i].x<balle.x+balle.largeur and balle.x+balle.largeur<listeBlocks[i].x+listeBlocks[i].largeur))then
				balle.speedY = -balle.speedY
			else
				balle.speedX = -balle.speedX
			end
			table.remove(listeBlocks, i)
			-- ca, ca marche pas (?)
		end
	end
	
-- Sinon j'avais une autre idee, avec la fonction touchOu()
--[[if(toucheOu(balle.x, balle.y, balle.largeur, balle.hauteur, listeBlocks[i].x, listeBlocks[i].y, listeBlocks[i].largeur, listeBlocks[i].hauteur) == droite 
			or toucheOu(balle.x, balle.y, balle.largeur, balle.hauteur, listeBlocks[i].x, listeBlocks[i].y, listeBlocks[i].largeur, listeBlocks[i].hauteur) == gauche) then
			balle.speedX = -balle.speedX
		end
		
		if(toucheOu(balle.x, balle.y, balle.largeur, balle.hauteur, listeBlocks[i].x, listeBlocks[i].y, listeBlocks[i].largeur, listeBlocks[i].hauteur) == bas 
			ortoucheOu(balle.x, balle.y, balle.largeur, balle.hauteur, listeBlocks[i].x, listeBlocks[i].y, listeBlocks[i].largeur, listeBlocks[i].hauteur) == haut) then
			balle.speedY = -balle.speedY
		end
	end]]
	
	difficulte = difficultyUp(barre.largeur)
	barre.largeur = difficulte
	
-- Temps passe depuis le lancement
	print(math.floor(time()/1000),0,0,10)
	
end