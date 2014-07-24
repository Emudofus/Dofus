package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.FightApi;
   import d2components.GraphicContainer;
   import d2components.Texture;
   import d2components.EntityDisplayer;
   import d2components.Label;
   import d2actions.*;
   import d2hooks.*;
   import flash.utils.getTimer;
   
   public class TurnStart extends Object
   {
      
      public function TurnStart() {
         super();
      }
      
      public static const POPUP_TIME:uint = 2000;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var fightApi:FightApi;
      
      private var _clockStart:uint;
      
      public var mainCtr:GraphicContainer;
      
      public var tx_picture:Object;
      
      public var tx_background:Texture;
      
      public var entityDisplayer:EntityDisplayer;
      
      public var lb_name:Label;
      
      public var lb_level:Label;
      
      public function main(params:Object) : void {
         this.sysApi.addEventListener(this.onEnterFrame,"time");
         this.restart(params.fighterId,params.waitingTime);
      }
      
      public function unload() : void {
         this.sysApi.removeEventListener(this.onEnterFrame);
      }
      
      public function restart(fighterId:int, waitingTime:uint) : void {
         var bgTextureWidth:* = NaN;
         var fighter:Object = this.fightApi.getFighterInformations(fighterId);
         this._clockStart = getTimer();
         this.lb_name.text = this.fightApi.getFighterName(fighterId);
         this.lb_level.text = this.uiApi.getText("ui.common.level") + " " + this.fightApi.getFighterLevel(fighterId);
         if(this.lb_name.textWidth > this.lb_level.textWidth)
         {
            bgTextureWidth = this.lb_name.textWidth + this.lb_name.x * 1.9;
         }
         else
         {
            bgTextureWidth = this.lb_level.textWidth + this.lb_level.x * 1.9;
         }
         this.tx_background.width = bgTextureWidth;
         this.entityDisplayer.look = this.fightApi.getFighterInformations(fighterId).look;
         this.entityDisplayer.useFade = false;
         this.entityDisplayer.setAnimationAndDirection("AnimArtwork",1);
         this.entityDisplayer.view = "turnstart";
         this.mainCtr.visible = true;
      }
      
      public function onEnterFrame() : void {
         var clock:uint = 0;
         var duration:* = 0;
         var myUi:Object = null;
         if(this.mainCtr.visible)
         {
            clock = getTimer();
            duration = clock - this._clockStart;
            myUi = this.uiApi.me();
            if(duration > POPUP_TIME)
            {
               this.mainCtr.visible = false;
            }
         }
      }
   }
}
