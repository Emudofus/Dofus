package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.dofus.datacenter.world.Phoenix;
   
   public class FlagManager extends Object
   {
      
      public function FlagManager() {
         super();
      }
      
      private static var _self:FlagManager;
      
      public static function getInstance() : FlagManager {
         var _loc1_:Array = null;
         var _loc2_:Phoenix = null;
         if(!_self)
         {
            _self = new FlagManager();
            _loc1_ = Phoenix.getAllPhoenixes();
            _self.phoenixs = new Array();
            for each (_loc2_ in _loc1_)
            {
               _self.phoenixs.push(_loc2_.mapId);
            }
         }
         return _self;
      }
      
      private var _phoenixs:Array;
      
      public function get phoenixs() : Array {
         return this._phoenixs;
      }
      
      public function set phoenixs(param1:Array) : void {
         this._phoenixs = param1;
      }
   }
}
