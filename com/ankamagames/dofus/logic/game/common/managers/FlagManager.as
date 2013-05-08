package com.ankamagames.dofus.logic.game.common.managers
{


   public class FlagManager extends Object
   {
         

      public function FlagManager() {
         this._phoenixs=new Array();
         super();
      }

      private static var _self:FlagManager;

      public static function getInstance() : FlagManager {
         if(!_self)
         {
            _self=new FlagManager();
         }
         return _self;
      }

      private var _phoenixs:Array;

      public function get phoenixs() : Array {
         return this._phoenixs;
      }

      public function set phoenixs(value:Array) : void {
         this._phoenixs=value;
      }
   }

}