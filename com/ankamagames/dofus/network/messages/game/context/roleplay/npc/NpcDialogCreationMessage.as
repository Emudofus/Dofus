package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NpcDialogCreationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NpcDialogCreationMessage() {
         super();
      }
      
      public static const protocolId:uint = 5618;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mapId:int = 0;
      
      public var npcId:int = 0;
      
      override public function getMessageId() : uint {
         return 5618;
      }
      
      public function initNpcDialogCreationMessage(mapId:int=0, npcId:int=0) : NpcDialogCreationMessage {
         this.mapId = mapId;
         this.npcId = npcId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mapId = 0;
         this.npcId = 0;
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
         this.serializeAs_NpcDialogCreationMessage(output);
      }
      
      public function serializeAs_NpcDialogCreationMessage(output:IDataOutput) : void {
         output.writeInt(this.mapId);
         output.writeInt(this.npcId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NpcDialogCreationMessage(input);
      }
      
      public function deserializeAs_NpcDialogCreationMessage(input:IDataInput) : void {
         this.mapId = input.readInt();
         this.npcId = input.readInt();
      }
   }
}
