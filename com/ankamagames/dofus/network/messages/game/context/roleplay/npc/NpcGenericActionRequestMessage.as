package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NpcGenericActionRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NpcGenericActionRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5898;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var npcId:int = 0;
      
      public var npcActionId:uint = 0;
      
      public var npcMapId:int = 0;
      
      override public function getMessageId() : uint {
         return 5898;
      }
      
      public function initNpcGenericActionRequestMessage(param1:int=0, param2:uint=0, param3:int=0) : NpcGenericActionRequestMessage {
         this.npcId = param1;
         this.npcActionId = param2;
         this.npcMapId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.npcId = 0;
         this.npcActionId = 0;
         this.npcMapId = 0;
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
         this.serializeAs_NpcGenericActionRequestMessage(param1);
      }
      
      public function serializeAs_NpcGenericActionRequestMessage(param1:IDataOutput) : void {
         param1.writeInt(this.npcId);
         if(this.npcActionId < 0)
         {
            throw new Error("Forbidden value (" + this.npcActionId + ") on element npcActionId.");
         }
         else
         {
            param1.writeByte(this.npcActionId);
            param1.writeInt(this.npcMapId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_NpcGenericActionRequestMessage(param1);
      }
      
      public function deserializeAs_NpcGenericActionRequestMessage(param1:IDataInput) : void {
         this.npcId = param1.readInt();
         this.npcActionId = param1.readByte();
         if(this.npcActionId < 0)
         {
            throw new Error("Forbidden value (" + this.npcActionId + ") on element of NpcGenericActionRequestMessage.npcActionId.");
         }
         else
         {
            this.npcMapId = param1.readInt();
            return;
         }
      }
   }
}
