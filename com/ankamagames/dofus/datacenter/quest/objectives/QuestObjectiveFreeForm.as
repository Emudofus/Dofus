package com.ankamagames.dofus.datacenter.quest.objectives
{
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   
   public class QuestObjectiveFreeForm extends QuestObjective implements IDataCenter
   {
      
      public function QuestObjectiveFreeForm() {
         super();
      }
      
      private var _freeFormText:String;
      
      public function get freeFormTextId() : uint {
         if(!this.parameters)
         {
            return 0;
         }
         return this.parameters[0];
      }
      
      public function get freeFormText() : String {
         if(!this._freeFormText)
         {
            this._freeFormText = I18n.getText(this.freeFormTextId);
         }
         return this._freeFormText;
      }
      
      override public function get text() : String {
         return this.freeFormText;
      }
   }
}
