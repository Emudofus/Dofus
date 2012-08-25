package com.ankamagames.jerakine.data
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class GameDataField extends Object
    {
        public var name:String;
        public var readData:Function;
        private var _innerReadMethods:Vector.<Function>;
        private var _innerTypeNames:Vector.<String>;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(GameDataField));
        private static const NULL_IDENTIFIER:int = -1.43166e+009;

        public function GameDataField(param1:String)
        {
            this.name = param1;
            return;
        }// end function

        public function readType(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readInt();
            this.readData = this.getReadMethod(_loc_2, param1);
            return;
        }// end function

        private function getReadMethod(param1:int, param2:IDataInput) : Function
        {
            switch(param1)
            {
                case -1:
                {
                    return this.readInteger;
                }
                case -2:
                {
                    return this.readBoolean;
                }
                case -3:
                {
                    return this.readString;
                }
                case -4:
                {
                    return this.readNumber;
                }
                case -5:
                {
                    return this.readI18n;
                }
                case -6:
                {
                    return this.readUnsignedInteger;
                }
                case -99:
                {
                    if (!this._innerReadMethods)
                    {
                        this._innerReadMethods = new Vector.<Function>;
                        this._innerTypeNames = new Vector.<String>;
                    }
                    this._innerTypeNames.push(param2.readUTF());
                    this._innerReadMethods.unshift(this.getReadMethod(param2.readInt(), param2));
                    return this.readVector;
                }
                default:
                {
                    if (param1 > 0)
                    {
                        return this.readObject;
                    }
                    throw new Error("Unknown type \'" + param1 + "\'.");
                    break;
                }
            }
        }// end function

        private function readVector(param1:String, param2:IDataInput, param3:uint = 0)
        {
            var _loc_4:* = param2.readInt();
            var _loc_5:* = this._innerTypeNames[param3];
            var _loc_6:* = new getDefinitionByName(_loc_5)(_loc_4, true);
            var _loc_7:uint = 0;
            while (_loc_7 < _loc_4)
            {
                
                var _loc_8:* = this._innerReadMethods;
                _loc_6[_loc_7] = _loc_8.this._innerReadMethods[param3](param1, param2, (param3 + 1));
                _loc_7 = _loc_7 + 1;
            }
            return _loc_6;
        }// end function

        private function readObject(param1:String, param2:IDataInput, param3:uint = 0)
        {
            var _loc_4:* = param2.readInt();
            if (param2.readInt() == NULL_IDENTIFIER)
            {
                return null;
            }
            var _loc_5:* = GameDataFileAccessor.getInstance().getClassDefinition(param1, _loc_4);
            return GameDataFileAccessor.getInstance().getClassDefinition(param1, _loc_4).read(param1, param2);
        }// end function

        private function readInteger(param1:String, param2:IDataInput, param3:uint = 0)
        {
            return param2.readInt();
        }// end function

        private function readBoolean(param1:String, param2:IDataInput, param3:uint = 0)
        {
            return param2.readBoolean();
        }// end function

        private function readString(param1:String, param2:IDataInput, param3:uint = 0)
        {
            return param2.readUTF();
        }// end function

        private function readNumber(param1:String, param2:IDataInput, param3:uint = 0)
        {
            return param2.readDouble();
        }// end function

        private function readI18n(param1:String, param2:IDataInput, param3:uint = 0)
        {
            return param2.readInt();
        }// end function

        private function readUnsignedInteger(param1:String, param2:IDataInput, param3:uint = 0)
        {
            return param2.readUnsignedInt();
        }// end function

    }
}
