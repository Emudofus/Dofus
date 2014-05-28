package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.enum.GameDataTypeEnum;
   import flash.utils.getDefinitionByName;
   
   public class GameDataField extends Object
   {
      
      public function GameDataField(fieldName:String) {
         super();
         this.name = fieldName;
      }
      
      private static const _log:Logger;
      
      private static const NULL_IDENTIFIER:int = -1.431655766E9;
      
      public var name:String;
      
      public var readData:Function;
      
      private var _innerReadMethods:Vector.<Function>;
      
      private var _innerTypeNames:Vector.<String>;
      
      public function readType(stream:IDataInput) : void {
         var type:int = stream.readInt();
         this.readData = this.getReadMethod(type,stream);
      }
      
      private function getReadMethod(type:int, stream:IDataInput) : Function {
         switch(type)
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
               this._innerTypeNames.push(stream.readUTF());
               this._innerReadMethods.unshift(this.getReadMethod(stream.readInt(),stream));
               return this.readVector;
            default:
               if(type > 0)
               {
                  return this.readObject;
               }
               throw new Error("Unknown type \'" + type + "\'.");
         }
      }
      
      private function readVector(moduleName:String, stream:IDataInput, innerIndex:uint = 0) : * {
         var len:uint = stream.readInt();
         var vectorTypeName:String = this._innerTypeNames[innerIndex];
         var content:* = new getDefinitionByName(vectorTypeName)(len,true);
         var i:uint = 0;
         while(i < len)
         {
            content[i] = this._innerReadMethods[innerIndex](moduleName,stream,innerIndex + 1);
            i++;
         }
         return content;
      }
      
      private function readObject(moduleName:String, stream:IDataInput, innerIndex:uint = 0) : * {
         var classIdentifier:int = stream.readInt();
         if(classIdentifier == NULL_IDENTIFIER)
         {
            return null;
         }
         var classDefinition:GameDataClassDefinition = GameDataFileAccessor.getInstance().getClassDefinition(moduleName,classIdentifier);
         return classDefinition.read(moduleName,stream);
      }
      
      private function readInteger(moduleName:String, stream:IDataInput, innerIndex:uint = 0) : * {
         return stream.readInt();
      }
      
      private function readBoolean(moduleName:String, stream:IDataInput, innerIndex:uint = 0) : * {
         return stream.readBoolean();
      }
      
      private function readString(moduleName:String, stream:IDataInput, innerIndex:uint = 0) : * {
         var result:* = stream.readUTF();
         if(result == "null")
         {
            result = null;
         }
         return result;
      }
      
      private function readNumber(moduleName:String, stream:IDataInput, innerIndex:uint = 0) : * {
         return stream.readDouble();
      }
      
      private function readI18n(moduleName:String, stream:IDataInput, innerIndex:uint = 0) : * {
         return stream.readInt();
      }
      
      private function readUnsignedInteger(moduleName:String, stream:IDataInput, innerIndex:uint = 0) : * {
         return stream.readUnsignedInt();
      }
   }
}
