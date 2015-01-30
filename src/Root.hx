import haxe.ds.Vector;
import starling.display.MovieClip;
import flash.xml.XML;

//import flash.display3D.textures.Texture;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
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


	//public var atlasTexture:Texture;
	//public var atlasXML:XML;
	
 
	//public var atlas:TextureAtlas;
	public var movie:MovieClip;
	
	
    public static var assets:AssetManager;
    public var heads:Image;
    public var tails:Image;
    public var BG:Image;
    public var p1: Player;
    public var p2: Player;
    public var p1Image:Image;
    public var p2Image:Image;
    public var headsButton:Image;
    public var tailsButton:Image;
    public var unpressedHeads:Button;
    public var unpressedTails:Button;
    public var pressedHeads:Button;
    public var pressedTails:Button;
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
		assets.enqueue("assets/tails.png");
        assets.enqueue("assets/heads.png");
        assets.enqueue("assets/player_ready.png");
        assets.enqueue("assets/boss_ready.png");
        assets.enqueue("assets/pressed heads.png");
        assets.enqueue("assets/pressed tails.png");
        assets.enqueue("assets/unpressed heads.png");
        assets.enqueue("assets/unpressed tails.png");
        assets.enqueue("assets/full_health.png");
        
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
						

                        headsButton = new Image(Root.assets.getTexture("unpressed heads"));
                        addChild(headsButton);
                        headsButton.x = 50;
                        headsButton.y = 260;

                        tailsButton = new Image(Root.assets.getTexture("unpressed tails"));
                        addChild(tailsButton);
                        tailsButton.x = 460;
                        tailsButton.y = 260;

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
                       
                        var ranNum:Float;
                       	ranNum = Math.round(Math.random());
                        //ranNum = 0;
                        
                        //trace("ranNum", ranNum);

                        //button functionality
                        function onHeadsTriggered(event:Event){
                            trace("Heads Pressed");
                            p1.choice = 1;
                        }
                        pressedHeads.addEventListener(Event.TRIGGERED, onHeadsTriggered);

                        function onTailsTriggered(event:Event){
                            trace("Tails Pressed");
                            p1.choice = 2;
                        }
                        pressedTails.addEventListener(Event.TRIGGERED, onTailsTriggered);
                       	
						
							//movieclip start
						addChild(movie);
						movie.play();
                        if(ranNum%2 == 1){
                        	tails = new Image(Root.assets.getTexture("tails"));
                       	 	//trace("tails", tails);
                        	tails.x = 250;
                        	tails.y = 250;

                            if(p1.choice == 1){
                                p2.health -= 1;
                            }
                            else{
                                p1.health -=1;
                            }


                            Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, 
                                function(event:KeyboardEvent){
                                    //trace(event.keyCode);
                                    if(event.keyCode == Keyboard.LEFT){
                                        tails.x -= 10;
                                        }
                                
                                    if(event.keyCode == Keyboard.RIGHT){
                                        tails.x += 10;
                                        }
                                });
                            
                                tails.addEventListener(TouchEvent.TOUCH, 
                                function(e:TouchEvent){
                                    var touch = e.getTouch(stage, TouchPhase.BEGAN);
                                    //trace("tails TOUCHED");
                                
                                });
								
                            Starling.juggler.tween(movie, 1.0, {

                            Starling.juggler.tween(tails, 1.0, {

                                transition: Transitions.EASE_OUT_BOUNCE,
                                    delay: 2.0,
                                    y: 250,
									onComplete: function add() { addChild(tails); removeChild(movie); }
                                    });
								

                        }else{
                        	heads = new Image(Root.assets.getTexture("heads"));
                       	 	//trace("heads", heads);
                        	heads.x = 250;
                        	heads.y = 250;

                            if(p1.choice == 0){
                                p2.health -= 1;
                            }
                            else{
                                p1.health -=1;
                            }


                            Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, 
                                function(event:KeyboardEvent){
                                    //trace(event.keyCode);
                                    if(event.keyCode == Keyboard.LEFT){
                                        heads.x -= 10;
                                    }
                                
                                    if(event.keyCode == Keyboard.RIGHT){
                                        heads.x += 10;
                                    }
                                });
                            
                                heads.addEventListener(TouchEvent.TOUCH, 
                                function(e:TouchEvent){
                                    var touch = e.getTouch(stage, TouchPhase.BEGAN);
                                    //trace("heads TOUCHED");
                                
                                });
								
                            Starling.juggler.tween(movie, 1.0, {

                            Starling.juggler.tween(heads, 1.0, {

                                transition: Transitions.EASE_OUT_BOUNCE,
                                    delay: 2.0,
                                    y: 250,
									onComplete: function add() { addChild(tails); removeChild(movie);}
                        });
						
                        }
			
						
                        if(p1.health == 0){
                            trace("You Lose!");
                        }

                        if(p2.health == 0){
                            trace("You Win!");
                        }
                        
                        

                    }

                });
            }

        });
    }

}
