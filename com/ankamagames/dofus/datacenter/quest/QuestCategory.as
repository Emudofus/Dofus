package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class QuestCategory extends Object implements IDataCenter
   {
      
      public function QuestCategory() {
         super();
      }
      
      public static const MODULE:String = "QuestCategory";
      
      public static function getQuestCategoryById(id:int) : QuestCategory {
         return GameData.getObject(MODULE,id) as QuestCategory;
      }
      
      public static function getQuestCategories() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var order:uint;
      
      public var questIds:Vector.<uint>;
      
      private var _name:String;
      
      private var _quests:Vector.<Quest>;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get quests() : Vector.<Quest> {
         var i:* = 0;
         var len:* = 0;
         if(!this._quests)
         {
            len = this.questIds.length;
            this._quests = new Vector.<Quest>(len,true);
            i = 0;
            while(i < len)
            {
               this._quests[i] = Quest.getQuestById(this.questIds[i]);
               i = i + 1;
            }
         }
         return this._quests;
      }
   }
}
