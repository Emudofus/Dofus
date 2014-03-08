package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   
   public class QuestCategory extends Object implements IDataCenter
   {
      
      public function QuestCategory() {
         super();
      }
      
      public static const MODULE:String = "QuestCategory";
      
      public static function getQuestCategoryById(param1:int) : QuestCategory {
         return GameData.getObject(MODULE,param1) as QuestCategory;
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
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(!this._quests)
         {
            _loc2_ = this.questIds.length;
            this._quests = new Vector.<Quest>(_loc2_,true);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this._quests[_loc1_] = Quest.getQuestById(this.questIds[_loc1_]);
               _loc1_ = _loc1_ + 1;
            }
         }
         return this._quests;
      }
   }
}
