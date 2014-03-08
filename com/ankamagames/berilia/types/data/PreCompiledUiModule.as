package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import flash.utils.IDataInput;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.uiDefinition.UiDefinition;
   import flash.utils.IDataOutput;
   import flash.net.ObjectEncoding;
   
   public class PreCompiledUiModule extends UiModule implements IModuleUtil
   {
      
      public function PreCompiledUiModule() {
         super();
      }
      
      private static const HEADER_STR:String = "D2UI";
      
      public static function fromRaw(param1:IDataInput, param2:String, param3:String) : PreCompiledUiModule {
         var _loc4_:PreCompiledUiModule = new PreCompiledUiModule();
         var _loc5_:ByteArray = new ByteArray();
         _loc4_._input = _loc5_;
         param1.readBytes(_loc5_);
         _loc5_.position = 0;
         var _loc6_:String = _loc5_.readUTF();
         if(_loc6_ != HEADER_STR)
         {
            throw new Error("Malformated ui data file.");
         }
         else
         {
            _loc4_.fillFromXml(new XML(_loc5_.readUTF()),param2,param3);
            _loc4_._definitionCount = _loc5_.readShort();
            _loc4_._uiListPosition = new Dictionary();
            _loc4_._cacheDefinition = new Dictionary();
            _loc7_ = 0;
            while(_loc7_ < _loc4_._definitionCount)
            {
               _loc4_._uiListPosition[_loc5_.readUTF()] = _loc5_.readInt();
               _loc7_++;
            }
            return _loc4_;
         }
      }
      
      public static function create(param1:UiModule) : PreCompiledUiModule {
         var _loc2_:PreCompiledUiModule = new PreCompiledUiModule();
         _loc2_.initWriteMode();
         _loc2_.makeHeader(param1);
         return _loc2_;
      }
      
      private var _uiListPosition:Dictionary;
      
      private var _definitionCount:uint;
      
      private var _uiListStartPosition:uint;
      
      private var _output:ByteArray;
      
      private var _uiBuffer:ByteArray;
      
      private var _input:ByteArray;
      
      private var _cacheDefinition:Dictionary;
      
      public function hasDefinition(param1:UiData) : Boolean {
         return !(this._uiListPosition[param1.name] == null);
      }
      
      public function getDefinition(param1:UiData) : UiDefinition {
         if(this.hasDefinition(param1))
         {
            if(this._cacheDefinition[param1.name])
            {
               return this._cacheDefinition[param1.name];
            }
            return this.readUidefinition(param1.name);
         }
         return null;
      }
      
      public function addUiDefinition(param1:UiDefinition, param2:UiData) : void {
         if(!this._output)
         {
            throw new Error("Call method \'create\' before using this method");
         }
         else
         {
            this.writeUiDefinition(param1,param2);
            return;
         }
      }
      
      public function flush(param1:IDataOutput) : void {
         var _loc2_:String = null;
         if(!this._output)
         {
            throw new Error("Call method \'create\' before using this method");
         }
         else
         {
            this._output.position = this._uiListStartPosition;
            this._output.writeShort(this._definitionCount);
            param1.writeBytes(this._output);
            this._output.position = this._output.length;
            _loc3_ = new ByteArray();
            for (_loc2_ in this._uiListPosition)
            {
               _loc3_.writeUTF(_loc2_);
               _loc3_.writeInt(0);
            }
            _loc3_.position = 0;
            for (_loc2_ in this._uiListPosition)
            {
               _loc3_.readUTF();
               _loc3_.writeInt(this._uiListPosition[_loc2_] + this._output.length + _loc3_.length);
            }
            param1.writeBytes(_loc3_);
            param1.writeBytes(this._uiBuffer);
            return;
         }
      }
      
      private function initWriteMode() : void {
         this._output = new ByteArray();
         this._uiBuffer = new ByteArray();
         this._uiListPosition = new Dictionary();
         this._uiBuffer.objectEncoding = ObjectEncoding.AMF3;
      }
      
      private function makeHeader(param1:UiModule) : void {
         this._output.writeUTF("D2UI");
         this._output.writeUTF(param1.rawXml.toXMLString());
         this._uiListStartPosition = this._output.position;
         this._output.writeShort(0);
      }
      
      private function readUidefinition(param1:String) : UiDefinition {
         this._input.objectEncoding = ObjectEncoding.AMF3;
         this._input.position = this._uiListPosition[param1];
         return this._input.readObject();
      }
      
      private function writeUiDefinition(param1:UiDefinition, param2:UiData) : void {
         this._definitionCount++;
         this._uiListPosition[param2.name] = this._uiBuffer.position;
         this._uiBuffer.objectEncoding = ObjectEncoding.AMF3;
         this._uiBuffer.writeObject(param1);
      }
   }
}
