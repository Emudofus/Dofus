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
      
      private static const _log:Logger;
      
      private static var _self:FightersStateManager;
      
      public static function getInstance() : FightersStateManager {
         if(!_self)
         {
            _self = new FightersStateManager();
         }
         return _self;
      }
      
      private var _entityStates:Dictionary;
      
      public function addStateOnTarget(stateId:int, targetId:int) : void {
         var stateList:Array = this._entityStates[targetId];
         if(!stateList)
         {
            stateList = new Array();
            this._entityStates[targetId] = stateList;
         }
         stateList.push(stateId);
      }
      
      public function removeStateOnTarget(stateId:int, targetId:int) : void {
         var stateList:Array = this._entityStates[targetId];
         if(!stateList)
         {
            _log.error("Can\'t find state list for " + targetId + " to remove state");
            return;
         }
         var index:int = stateList.indexOf(stateId);
         if(index != -1)
         {
            stateList.splice(index,1);
         }
      }
      
      public function hasState(targetId:int, stateId:int) : Boolean {
         var stateList:Array = this._entityStates[targetId];
         if(!stateList)
         {
            return false;
         }
         return !(stateList.indexOf(stateId) == -1);
      }
      
      public function getStates(targetId:int) : Array {
         return this._entityStates[targetId];
      }
      
      public function endFight() : void {
         this._entityStates = new Dictionary();
      }
   }
}
