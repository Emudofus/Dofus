package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstant;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class ServerSessionConstantsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ServerSessionConstantsMessage() {
         this.variables = new Vector.<ServerSessionConstant>();
         super();
      }
      
      public static const protocolId:uint = 6434;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var variables:Vector.<ServerSessionConstant>;
      
      override public function getMessageId() : uint {
         return 6434;
      }
      
      public function initServerSessionConstantsMessage(param1:Vector.<ServerSessionConstant>=null) : ServerSessionConstantsMessage {
         this.variables = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.variables = new Vector.<ServerSessionConstant>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ServerSessionConstantsMessage(param1);
      }
      
      public function serializeAs_ServerSessionConstantsMessage(param1:IDataOutput) : void {
         param1.writeShort(this.variables.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.variables.length)
         {
            param1.writeShort((this.variables[_loc2_] as ServerSessionConstant).getTypeId());
            (this.variables[_loc2_] as ServerSessionConstant).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ServerSessionConstantsMessage(param1);
      }
      
      public function deserializeAs_ServerSessionConstantsMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:ServerSessionConstant = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(ServerSessionConstant,_loc4_);
            _loc5_.deserialize(param1);
            this.variables.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
