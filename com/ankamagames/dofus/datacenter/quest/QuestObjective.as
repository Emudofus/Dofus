package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import flash.geom.Point;
   import com.ankamagames.dofus.datacenter.npcs.NpcMessage;
   
   public class QuestObjective extends Object implements IDataCenter
   {
      
      public function QuestObjective() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestObjective));
      
      public static const MODULE:String = "QuestObjectives";
      
      public static function getQuestObjectiveById(id:int) : QuestObjective {
         return GameData.getObject(MODULE,id) as QuestObjective;
      }
      
      public static function getQuestObjectives() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var stepId:uint;
      
      public var typeId:uint;
      
      public var dialogId:int;
      
      public var parameters:Vector.<uint>;
      
      public var coords:Point;
      
      public var mapId:int;
      
      private var _step:QuestStep;
      
      private var _type:QuestObjectiveType;
      
      private var _text:String;
      
      private var _dialog:String;
      
      public function get step() : QuestStep {
         if(!this._step)
         {
            this._step = QuestStep.getQuestStepById(this.stepId);
         }
         return this._step;
      }
      
      public function get type() : QuestObjectiveType {
         if(!this._type)
         {
            this._type = QuestObjectiveType.getQuestObjectiveTypeById(this.typeId);
         }
         return this._type;
      }
      
      public function get text() : String {
         if(!this._text)
         {
            _log.warn("Unknown objective type " + this.typeId + ", cannot display specific, parametrized text.");
            this._text = this.type.name;
         }
         return this._text;
      }
      
      public function get dialog() : String {
         if(this.dialogId < 1)
         {
            return "";
         }
         if(!this._dialog)
         {
            this._dialog = NpcMessage.getNpcMessageById(this.dialogId).message;
         }
         return this._dialog;
      }
   }
}
