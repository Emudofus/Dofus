package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class EntityTalkMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function EntityTalkMessage() {
         this.parameters = new Vector.<String>();
         super();
      }
      
      public static const protocolId:uint = 6110;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var entityId:int = 0;
      
      public var textId:uint = 0;
      
      public var parameters:Vector.<String>;
      
      override public function getMessageId() : uint {
         return 6110;
      }
      
      public function initEntityTalkMessage(param1:int=0, param2:uint=0, param3:Vector.<String>=null) : EntityTalkMessage {
         this.entityId = param1;
         this.textId = param2;
         this.parameters = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.entityId = 0;
         this.textId = 0;
         this.parameters = new Vector.<String>();
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
         this.serializeAs_EntityTalkMessage(param1);
      }
      
      public function serializeAs_EntityTalkMessage(param1:IDataOutput) : void {
         param1.writeInt(this.entityId);
         if(this.textId < 0)
         {
            throw new Error("Forbidden value (" + this.textId + ") on element textId.");
         }
         else
         {
            param1.writeShort(this.textId);
            param1.writeShort(this.parameters.length);
            _loc2_ = 0;
            while(_loc2_ < this.parameters.length)
            {
               param1.writeUTF(this.parameters[_loc2_]);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_EntityTalkMessage(param1);
      }
      
      public function deserializeAs_EntityTalkMessage(param1:IDataInput) : void {
         var _loc4_:String = null;
         this.entityId = param1.readInt();
         this.textId = param1.readShort();
         if(this.textId < 0)
         {
            throw new Error("Forbidden value (" + this.textId + ") on element of EntityTalkMessage.textId.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUTF();
               this.parameters.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
