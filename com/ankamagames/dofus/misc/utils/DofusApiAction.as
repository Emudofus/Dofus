package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.berilia.types.data.ApiAction;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.misc.ActionDescription;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class DofusApiAction extends ApiAction
   {
      
      public function DofusApiAction(name:String, actionClass:Class) {
         _actionList.push(this);
         super(name,actionClass,true,false,0,0,false);
      }
      
      protected static const _log:Logger;
      
      private static var _actionList:Vector.<DofusApiAction>;
      
      public static function updateInfo() : void {
         var action:DofusApiAction = null;
         var actiondesc:ActionDescription = null;
         for each(action in _actionList)
         {
            actiondesc = ActionDescription.getActionDescriptionByName(action.name);
            if(actiondesc)
            {
               action._trusted = actiondesc.trusted;
               action._needInteraction = actiondesc.needInteraction;
               action._maxUsePerFrame = actiondesc.maxUsePerFrame;
               action._minimalUseInterval = actiondesc.minimalUseInterval;
               action._needConfirmation = actiondesc.needConfirmation;
               action._description = actiondesc.description;
            }
            else
            {
               _log.warn("No data for Action \'" + action.name + "\'");
            }
         }
      }
      
      public static function getApiActionByName(name:String) : DofusApiAction {
         return _apiActionNameList[name];
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
