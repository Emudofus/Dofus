package com.ankamagames.dofus.datacenter.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.geom.*;
    import flash.utils.*;

    public class QuestObjective extends Object implements IDataCenter
    {
        public var id:uint;
        public var stepId:uint;
        public var typeId:uint;
        public var dialogId:int;
        public var parameters:Vector.<uint>;
        public var coords:Point;
        private var _step:QuestStep;
        private var _type:QuestObjectiveType;
        private var _text:String;
        private var _dialog:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestObjective));
        private static const MODULE:String = "QuestObjectives";

        public function QuestObjective()
        {
            return;
        }// end function

        public function get step() : QuestStep
        {
            if (!this._step)
            {
                this._step = QuestStep.getQuestStepById(this.stepId);
            }
            return this._step;
        }// end function

        public function get type() : QuestObjectiveType
        {
            if (!this._type)
            {
                this._type = QuestObjectiveType.getQuestObjectiveTypeById(this.typeId);
            }
            return this._type;
        }// end function

        public function get text() : String
        {
            if (!this._text)
            {
                _log.warn("Unknown objective type " + this.typeId + ", cannot display specific, parametrized text.");
                this._text = this.type.name;
            }
            return this._text;
        }// end function

        public function get dialog() : String
        {
            if (this.dialogId < 1)
            {
                return "";
            }
            if (!this._dialog)
            {
                this._dialog = NpcMessage.getNpcMessageById(this.dialogId).message;
            }
            return this._dialog;
        }// end function

        public static function getQuestObjectiveById(param1:int) : QuestObjective
        {
            return GameData.getObject(MODULE, param1) as QuestObjective;
        }// end function

        public static function getQuestObjectives() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
