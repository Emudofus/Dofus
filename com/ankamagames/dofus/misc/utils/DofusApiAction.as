package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.berilia.types.data.ApiAction;
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.misc.ActionDescription;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class DofusApiAction extends ApiAction
   {
      
      public function DofusApiAction(param1:String, param2:Class) {
         _actionList.push(this);
         super(param1,param2,true,false,0,0,false);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DofusApiAction));
      
      private static var _actionList:Vector.<DofusApiAction> = new Vector.<DofusApiAction>();
      
      public static function updateInfo() : void {
         var _loc1_:DofusApiAction = null;
         var _loc2_:ActionDescription = null;
         for each (_loc1_ in _actionList)
         {
            _loc2_ = ActionDescription.getActionDescriptionByName(_loc1_.name);
            if(_loc2_)
            {
               _loc1_._trusted = _loc2_.trusted;
               _loc1_._needInteraction = _loc2_.needInteraction;
               _loc1_._maxUsePerFrame = _loc2_.maxUsePerFrame;
               _loc1_._minimalUseInterval = _loc2_.minimalUseInterval;
               _loc1_._needConfirmation = _loc2_.needConfirmation;
               _loc1_._description = _loc2_.description;
            }
            else
            {
               _log.warn("No data for Action \'" + _loc1_.name + "\'");
            }
         }
      }
      
      public static function getApiActionByName(param1:String) : DofusApiAction {
         return _apiActionNameList[param1];
      }
      
      public static function getApiActionsList() : Array {
         return _apiActionNameList;
      }
      
      private var _description:String;
      
      public function get description() : String {
         return this._description;
      }
   }
}
