package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   
   public class FightersStateManager extends Object
   {
      
      public function FightersStateManager() {
         this._entityStates = new Dictionary();
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(FightersStateManager));
      
      private static var _self:FightersStateManager;
      
      public static function getInstance() : FightersStateManager {
         if(!_self)
         {
            _self = new FightersStateManager();
         }
         return _self;
      }
      
      private var _entityStates:Dictionary;
      
      public function addStateOnTarget(param1:int, param2:int) : void {
         var _loc3_:Array = this._entityStates[param2];
         if(!_loc3_)
         {
            _loc3_ = new Array();
            this._entityStates[param2] = _loc3_;
         }
         _loc3_.push(param1);
      }
      
      public function removeStateOnTarget(param1:int, param2:int) : void {
         var _loc3_:Array = this._entityStates[param2];
         if(!_loc3_)
         {
            _log.error("Can\'t find state list for " + param2 + " to remove state");
            return;
         }
         var _loc4_:int = _loc3_.indexOf(param1);
         if(_loc4_ != -1)
         {
            _loc3_.splice(_loc4_,1);
         }
      }
      
      public function hasState(param1:int, param2:int) : Boolean {
         var _loc3_:Array = this._entityStates[param1];
         if(!_loc3_)
         {
            return false;
         }
         return !(_loc3_.indexOf(param2) == -1);
      }
      
      public function getStates(param1:int) : Array {
         return this._entityStates[param1];
      }
      
      public function endFight() : void {
         this._entityStates = new Dictionary();
      }
   }
}
