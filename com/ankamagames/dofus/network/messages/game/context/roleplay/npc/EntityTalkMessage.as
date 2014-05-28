package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initEntityTalkMessage(entityId:int = 0, textId:uint = 0, parameters:Vector.<String> = null) : EntityTalkMessage {
         this.entityId = entityId;
         this.textId = textId;
         this.parameters = parameters;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.entityId = 0;
         this.textId = 0;
         this.parameters = new Vector.<String>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_EntityTalkMessage(output);
      }
      
      public function serializeAs_EntityTalkMessage(output:IDataOutput) : void {
         output.writeInt(this.entityId);
         if(this.textId < 0)
         {
            throw new Error("Forbidden value (" + this.textId + ") on element textId.");
         }
         else
         {
            output.writeShort(this.textId);
            output.writeShort(this.parameters.length);
            _i3 = 0;
            while(_i3 < this.parameters.length)
            {
               output.writeUTF(this.parameters[_i3]);
               _i3++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_EntityTalkMessage(input);
      }
      
      public function deserializeAs_EntityTalkMessage(input:IDataInput) : void {
         var _val3:String = null;
         this.entityId = input.readInt();
         this.textId = input.readShort();
         if(this.textId < 0)
         {
            throw new Error("Forbidden value (" + this.textId + ") on element of EntityTalkMessage.textId.");
         }
         else
         {
            _parametersLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _parametersLen)
            {
               _val3 = input.readUTF();
               this.parameters.push(_val3);
               _i3++;
            }
            return;
         }
      }
   }
}
