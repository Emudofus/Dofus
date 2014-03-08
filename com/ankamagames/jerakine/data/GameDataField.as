package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.enum.GameDataTypeEnum;
   import flash.utils.getDefinitionByName;
   
   public class GameDataField extends Object
   {
      
      public function GameDataField(param1:String) {
         super();
         this.name = param1;
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(GameDataField));
      
      private static const NULL_IDENTIFIER:int = -1431655766;
      
      public var name:String;
      
      public var readData:Function;
      
      private var _innerReadMethods:Vector.<Function>;
      
      private var _innerTypeNames:Vector.<String>;
      
      public function readType(param1:IDataInput) : void {
         var _loc2_:int = param1.readInt();
         this.readData = this.getReadMethod(_loc2_,param1);
      }
      
      private function getReadMethod(param1:int, param2:IDataInput) : Function {
         switch(param1)
         {
            case GameDataTypeEnum.INT:
               return this.readInteger;
            case GameDataTypeEnum.BOOLEAN:
               return this.readBoolean;
            case GameDataTypeEnum.STRING:
               return this.readString;
            case GameDataTypeEnum.NUMBER:
               return this.readNumber;
            case GameDataTypeEnum.I18N:
               return this.readI18n;
            case GameDataTypeEnum.UINT:
               return this.readUnsignedInteger;
            case GameDataTypeEnum.VECTOR:
               if(!this._innerReadMethods)
               {
                  this._innerReadMethods = new Vector.<Function>();
                  this._innerTypeNames = new Vector.<String>();
               }
               this._innerTypeNames.push(param2.readUTF());
               this._innerReadMethods.unshift(this.getReadMethod(param2.readInt(),param2));
               return this.readVector;
            default:
               if(param1 > 0)
               {
                  return this.readObject;
               }
               throw new Error("Unknown type \'" + param1 + "\'.");
         }
      }
      
      private function readVector(param1:String, param2:IDataInput, param3:uint=0) : * {
         var _loc4_:uint = param2.readInt();
         var _loc5_:String = this._innerTypeNames[param3];
         var _loc6_:* = new getDefinitionByName(_loc5_)(_loc4_,true);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc4_)
         {
            _loc6_[_loc7_] = this._innerReadMethods[param3](param1,param2,param3 + 1);
            _loc7_++;
         }
         return _loc6_;
      }
      
      private function readObject(param1:String, param2:IDataInput, param3:uint=0) : * {
         var _loc4_:int = param2.readInt();
         if(_loc4_ == NULL_IDENTIFIER)
         {
            return null;
         }
         var _loc5_:GameDataClassDefinition = GameDataFileAccessor.getInstance().getClassDefinition(param1,_loc4_);
         return _loc5_.read(param1,param2);
      }
      
      private function readInteger(param1:String, param2:IDataInput, param3:uint=0) : * {
         return param2.readInt();
      }
      
      private function readBoolean(param1:String, param2:IDataInput, param3:uint=0) : * {
         return param2.readBoolean();
      }
      
      private function readString(param1:String, param2:IDataInput, param3:uint=0) : * {
         var _loc4_:* = param2.readUTF();
         if(_loc4_ == "null")
         {
            _loc4_ = null;
         }
         return _loc4_;
      }
      
      private function readNumber(param1:String, param2:IDataInput, param3:uint=0) : * {
         return param2.readDouble();
      }
      
      private function readI18n(param1:String, param2:IDataInput, param3:uint=0) : * {
         return param2.readInt();
      }
      
      private function readUnsignedInteger(param1:String, param2:IDataInput, param3:uint=0) : * {
         return param2.readUnsignedInt();
      }
   }
}
