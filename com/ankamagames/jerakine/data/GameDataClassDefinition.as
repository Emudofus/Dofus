package com.ankamagames.jerakine.data
{
    import __AS3__.vec.Vector;
    import flash.utils.getDefinitionByName;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class GameDataClassDefinition 
    {

        private var _class:Class;
        private var _fields:Vector.<GameDataField>;

        public function GameDataClassDefinition(packageName:String, className:String)
        {
            this._class = (getDefinitionByName(((packageName + ".") + className)) as Class);
            this._fields = new Vector.<GameDataField>();
        }

        public function get fields():Vector.<GameDataField>
        {
            return (this._fields);
        }

        public function read(module:String, stream:IDataInput)
        {
            var field:GameDataField;
            var inst:* = new this._class();
            for each (field in this._fields)
            {
                inst[field.name] = field.readData(module, stream);
            };
            if ((inst is IPostInit))
            {
                IPostInit(inst).postInit();
            };
            return (inst);
        }

        public function addField(fieldName:String, stream:IDataInput):void
        {
            var field:GameDataField = new GameDataField(fieldName);
            field.readType(stream);
            this._fields.push(field);
        }


    }
}//package com.ankamagames.jerakine.data

