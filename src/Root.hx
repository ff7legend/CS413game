import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import Player;

class Root extends Sprite {



    public static var assets:AssetManager;
    public var heads:Image;
    public var tails:Image;
    public var BG:Image;
    public var p1: Player;
    public var p2: Player;
    public var p1Image:Image;
    public var p2Image:Image;
    public var unpressedHeads:Image;
    public var unpressedTails:Image;
    public var pressedHeads:Image;
    public var pressedTails:Image;
    public var p1Health:Image;
    public var p2Health:Image;

    public function new() {
        super();
    }

    public function start(startup:Startup) {
    

        assets = new AssetManager();
	
		assets.enqueue("assets/BG.png");
		assets.enqueue("assets/tails.png");
        assets.enqueue("assets/heads.png");
        assets.enqueue("assets/player_ready.png");
        assets.enqueue("assets/boss_ready.png");
        assets.enqueue("assets/pressed heads.png");
        assets.enqueue("assets/pressed Tails.png");
        assets.enqueue("assets/unpressed heads.png");
        assets.enqueue("assets/unpressed Tails.png");
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
                    	BG = new Image(Root.assets.getTexture("BG"));
                    	addChild(BG);

                        unpressedHeads = new Image(Root.assets.getTexture("unpressed heads"));
                        addChild(unpressedHeads);
                        unpressedHeads.x = 50;
                        unpressedHeads.y = 260;
                        pressedHeads = new Image(Root.assets.getTexture("pressed heads"));
                        addChild(pressedHeads);
                        pressedHeads.x = 50;
                        pressedHeads.y = 260;
                        pressedHeads.visible = false;

                        unpressedTails = new Image(Root.assets.getTexture("unpressed Tails"));
                        addChild(unpressedTails);
                        unpressedTails.x = 460;
                        unpressedTails.y = 260;
                        pressedTails = new Image(Root.assets.getTexture("pressed Tails"));
                        addChild(pressedTails);
                        pressedTails.x = 460;
                        pressedTails.y = 260;
                        pressedHeads.visible = false;

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
                       	
                        if(ranNum%2 == 1){
                        	tails = new Image(Root.assets.getTexture("tails"));
                       	 	addChild(tails);
                            //trace("tails", tails);
                        	tails.x = 250;
                        	tails.y = 0;

                            if(p1.choice == 1){
                                p2.health -= 1;
                            }
                            else{
                                p1.health -=1;
                            }

                            Starling.juggler.tween(tails, 1.0, {
                                transition: Transitions.EASE_OUT_BOUNCE,
                                    delay: 2.0,
                                    y: 250
                                    });

                        }else{
                        	heads = new Image(Root.assets.getTexture("heads"));
                       	 	addChild(heads);
                            //trace("heads", heads);
                        	heads.x = 250;
                        	heads.y = 0;

                            if(p1.choice == 0){
                                p2.health -= 1;
                            }
                            else{
                                p1.health -=1;
                            }

                            Starling.juggler.tween(heads, 1.0, {
                                transition: Transitions.EASE_OUT_BOUNCE,
                                    delay: 2.0,
                                    y: 250
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
