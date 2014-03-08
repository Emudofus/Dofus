package com.ankamagames.dofus.logic.game.roleplay.types
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   
   public class EntityIcon extends Sprite
   {
      
      public function EntityIcon() {
         super();
         this._icons = new Dictionary(true);
      }
      
      private var _icons:Dictionary;
      
      private var _nbIcons:int;
      
      public var needUpdate:Boolean;
      
      public var rendering:Boolean;
      
      public function addIcon(param1:String, param2:String) : void {
         this._icons[param2] = new Texture();
         var _loc3_:Texture = this._icons[param2];
         _loc3_.uri = new Uri(param1);
         _loc3_.dispatchMessages = true;
         _loc3_.addEventListener(Event.COMPLETE,this.iconRendered);
         _loc3_.finalize();
         this._nbIcons++;
      }
      
      public function removeIcon(param1:String) : void {
         var _loc2_:Texture = this._icons[param1];
         if(_loc2_)
         {
            if(_loc2_.parent == this)
            {
               removeChild(_loc2_);
            }
            delete this._icons[[param1]];
            this._nbIcons--;
            if(numChildren == this._nbIcons)
            {
               for each (_loc2_ in this._icons)
               {
                  removeChild(_loc2_);
               }
               for each (_loc2_ in this._icons)
               {
                  _loc2_.x = width == 0?_loc2_.width / 2:width + 5 + _loc2_.width / 2;
                  addChild(_loc2_);
               }
               this.needUpdate = true;
            }
         }
      }
      
      public function hasIcon(param1:String) : Boolean {
         return this._icons[param1];
      }
      
      public function get length() : int {
         return this._nbIcons;
      }
      
      public function remove() : void {
         parent.removeChild(this);
      }
      
      private function iconRendered(param1:Event) : void {
         var _loc2_:Texture = param1.currentTarget as Texture;
         _loc2_.removeEventListener(Event.COMPLETE,this.iconRendered);
         _loc2_.x = width == 0?_loc2_.width / 2:width + 5 + _loc2_.width / 2;
         addChild(_loc2_);
         this.needUpdate = true;
      }
   }
}
