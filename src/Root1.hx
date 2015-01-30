
import starling.display.MovieClip;

import starling.textures.Texture;

import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.events.EventDispatcher;
import starling.display.Button;
import starling.events.Event;

import Player;

class Root extends Sprite {
	public var movie:MovieClip;
	public var bool:Bool = false;
    public static var assets:AssetManager;
    public var heads:Image;
    public var tails:Image;
    public var BG:Image;
    public var p1: Player;
    public var p2: Player;
    public var p1Image:Image;
    public var p2Image:Image;
    public var unpressedHeads:Button;
    public var unpressedTails:Button;
    public var pressedHeads:Button;
    public var pressedTails:Button;
    public var headsButton:Image;
    public var tailsButton:Image;
	public var youwin:Image;
	public var youlose:Image;
    public var p1Health:Image;
    public var p2Health:Image;

    public function new() {
        super();
    }

    public function start(startup:Startup) {
    

        assets = new AssetManager();
		assets.enqueue("assets/coin_01.png");
		assets.enqueue("assets/coin_00.png");
		
		assets.enqueue("assets/BG.png");
		assets.enqueue("assets/youlose.png");
		assets.enqueue("assets/youwin.png");
		assets.enqueue("assets/tails.png");
        assets.enqueue("assets/heads.png");
        assets.enqueue("assets/player_ready.png");
        assets.enqueue("assets/boss_ready.png");
		assets.enqueue("assets/player_win.png");
        assets.enqueue("assets/boss_win.png");
		assets.enqueue("assets/player_lose.png");
        assets.enqueue("assets/boss_lose.png");
        assets.enqueue("assets/pressed heads.png");
        assets.enqueue("assets/pressed tails.png");
        assets.enqueue("assets/unpressed heads.png");
        assets.enqueue("assets/unpressed tails.png");
        assets.enqueue("assets/full_health.png");
		assets.enqueue("assets/one_damage_health.png");
		assets.enqueue("assets/two_damage_health.png");
		assets.enqueue("assets/three_damage_health.png");
        
        assets.loadQueue(function onProgress(ratio:Int) {
		
            if (ratio == 1) {

                //trace("startup", startup);
                //trace("startup.loadingBitmap", startup.loadingBitmap);
               
                //trace("p1", p1);
                //trace("p2", p2);
	
                Starling.juggler.tween(startup.loadingBitmap, 2.0, {

                    transition: Transitions.EASE_OUT,
                        delay: 1.0,
                        alpha: 0,
                        onComplete: function() {
                        startup.removeChild(startup.loadingBitmap);
                        
                        //add sprites into game
						
						movie = new MovieClip(Root.assets.getTextures("coin_"),12);
						movie.loop = true;
						movie.x = 250;
						movie.y = 0;
						
						
                    	BG = new Image(Root.assets.getTexture("BG"));
                    	addChild(BG);
						

						Starling.juggler.add(movie);
					/*	unpressedHeads = new Button(Root.assets.getTexture("unpressed heads"));
                        addChild(unpressedHeads);
                        unpressedHeads.x = 50;
                        unpressedHeads.y = 260;*/
                        
						pressedHeads = new Button(Root.assets.getTexture("pressed heads"));
                        addChild(pressedHeads);
                        pressedHeads.x = 50;
                        pressedHeads.y = 260;
                        //pressedHeads.visible = false;
						
						/*unpressedTails = new Button(Root.assets.getTexture("unpressed tails"));
                        addChild(unpressedTails);
                        unpressedTails.x = 460;
                        unpressedTails.y = 260;
                        */
                        
                        pressedTails = new Button(Root.assets.getTexture("pressed tails"));
                        addChild(pressedTails);
                        pressedTails.x = 460;
                        pressedTails.y = 260;
                        //pressedTails.visible = false;
						
/*
                        headsButton = new Image(Root.assets.getTexture("unpressed heads"));
                        addChild(headsButton);
                        headsButton.x = 50;
                        headsButton.y = 260;

                        tailsButton = new Image(Root.assets.getTexture("unpressed tails"));
                        addChild(tailsButton);
                        tailsButton.x = 460;
                        tailsButton.y = 260;*/

                        p1Image = new Image(Root.assets.getTexture("player_ready"));
                        addChild(p1Image);
                        p1Image.x = 50;
                        p1Image.y = 160;

                        p2Image = new Image(Root.assets.getTexture("boss_ready"));
                        addChild(p2Image);
                        p2Image.x = 450;
                        p2Image.y = 60;

                        p1Health = new Image(Root.assets.getTexture("full_health"));
                        addChild(p1Health);
                        p1Health.x = 20;
                        p1Health.y = 150;

                        p2Health = new Image(Root.assets.getTexture("full_health"));
                        addChild(p2Health);
                        p2Health.x = 600;
                        p2Health.y = 60;

						
                        //trace("heads", heads);
                        //trace("tails", tails);

                        p1 = new Player();
                        //trace("p1 health", p1.health);
                        p2 = new Player();
                        //trace("p2 health", p2.health);
                       
						
						
						
						
						
						
                        var ranNum:Int;
                       	ranNum = Math.round(Math.random());
                        //ranNum = 0;
                        
                        

							
						
							//movieclip start
						addChild(movie);
						//game logic begins
						
						function logic(){
							//movie.pause();
								
								
									if(ranNum%2 == 1){
										tails = new Image(Root.assets.getTexture("tails"));
										//trace("tails", tails);
										tails.x = 250;
										tails.y = 250;

										
										if(p1.choice == 0){
											p2.health -= 1;
											if (p2.health == 3) { p2Health.texture = Root.assets.getTexture("one_damage_health"); }
											if (p2.health == 2) { p2Health.texture = Root.assets.getTexture("two_damage_health"); }
											if (p2.health == 1) { p2Health.texture = Root.assets.getTexture("three_damage_health"); }
											
										}
										else{
											p1.health -= 1;
											if (p1.health == 3) { p1Health.texture = Root.assets.getTexture("one_damage_health"); }
											if (p1.health == 2) { p1Health.texture = Root.assets.getTexture("two_damage_health"); }
											if (p1.health == 1) { p1Health.texture = Root.assets.getTexture("three_damage_health"); }
										}
									   

										Starling.juggler.tween(movie, 1.0, {

											transition: Transitions.EASE_OUT_BOUNCE,
												delay: 2.0,
												y: 250,
												onComplete: function add() { 
													addChild(tails); removeChild(movie); movie.x = 250; movie.y = 0; addChild(movie); p1.choice = 0; 
													if(p1.health == 0){
														//trace("You Lose!");
														removeChild(movie);
														youlose = new Image(Root.assets.getTexture("youlose"));
														addChild(youlose);
														youlose.x = 240;
														youlose.y = 90;
														
														p2Image.texture = Root.assets.getTexture("boss_win");
														p1Image.texture = Root.assets.getTexture("player_lose");
													}

													else if(p2.health == 0){
														//trace("You Win!");
														removeChild(movie);
														youwin = new Image(Root.assets.getTexture("youwin"));
														addChild(youwin);
														youwin.x = 240;
														youwin.y = 90;
														p2Image.texture = Root.assets.getTexture("boss_lose");
														p1Image.texture = Root.assets.getTexture("player_win");
													}
													}
												});
											

									}else{
										heads = new Image(Root.assets.getTexture("heads"));
										//trace("heads", heads);
										heads.x = 250;
										heads.y = 250;

										if(p1.choice == 1){
											p2.health -= 1;
											if (p2.health == 3) { p2Health.texture = Root.assets.getTexture("one_damage_health"); }
											if (p2.health == 2) { p2Health.texture = Root.assets.getTexture("two_damage_health"); }
											if (p2.health == 1) { p2Health.texture = Root.assets.getTexture("three_damage_health"); }
											
										}
										else{
											p1.health -= 1;
											if (p1.health == 3) { p1Health.texture = Root.assets.getTexture("one_damage_health"); }
											if (p1.health == 2) { p1Health.texture = Root.assets.getTexture("two_damage_health"); }
											if (p1.health == 1) { p1Health.texture = Root.assets.getTexture("three_damage_health"); }
										}
										
									
										Starling.juggler.tween(movie, 1.0, {

											transition: Transitions.EASE_OUT_BOUNCE,
												delay: 2.0,
												y: 250,
												onComplete: function add() { addChild(heads); removeChild(movie); movie.x = 250; movie.y = 0; addChild(movie); p1.choice = 0;
													if(p1.health == 0){
														//trace("You Lose!");
														removeChild(movie);
														youlose = new Image(Root.assets.getTexture("youlose"));
														addChild(youlose);
														youlose.x = 240;
														youlose.y = 90;
														
														p2Image.texture = Root.assets.getTexture("boss_win");
														p1Image.texture = Root.assets.getTexture("player_lose");
													}

													else if(p2.health == 0){
														//trace("You Win!");
														removeChild(movie);
														youwin = new Image(Root.assets.getTexture("youwin"));
														addChild(youwin);
														youwin.x = 240;
														youwin.y = 90;
														p2Image.texture = Root.assets.getTexture("boss_lose");
														p1Image.texture = Root.assets.getTexture("player_win");
													}
												}
									});
									}
									
								
								
						}//end logic()
						
                        //button functionality
                        function onHeadsTriggered(event:Event){
                           
                            p1.choice = 1;
							ranNum = Math.round(Math.random());
							removeChild(heads);
							removeChild(tails);
							logic();
							
                        }
                        pressedHeads.addEventListener(Event.TRIGGERED, onHeadsTriggered);

                        function onTailsTriggered(event:Event){
                           
                            p1.choice = 0;
							ranNum = Math.round(Math.random());
							removeChild(heads);
							removeChild(tails);
							logic();
							
                        }
                        pressedTails.addEventListener(Event.TRIGGERED, onTailsTriggered);
                       
                    
                    }//end onComplete

                });
            }

        });
    }

}
