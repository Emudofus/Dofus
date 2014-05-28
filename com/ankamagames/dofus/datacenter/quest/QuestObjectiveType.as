package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   
   public class QuestObjectiveType extends Object implements IDataCenter
   {
      
      public function QuestObjectiveType() {
         super();
      }
      
      protected static const _log:Logger;
      
      public static const MODULE:String = "QuestObjectiveTypes";
      
      public static function getQuestObjectiveTypeById(id:int) : QuestObjectiveType {
         return GameData.getObject(MODULE,id) as QuestObjectiveType;
      }
      
      public static function getQuestObjectiveTypes() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
