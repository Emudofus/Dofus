package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class DungeonPartyFinderListenRequestMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function DungeonPartyFinderListenRequestMessage() {
         super();
      }

      public static const protocolId:uint = 6246;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var dungeonId:uint = 0;

      override public function getMessageId() : uint {
         return 6246;
      }

      public function initDungeonPartyFinderListenRequestMessage(dungeonId:uint=0) : DungeonPartyFinderListenRequestMessage {
         this.dungeonId=dungeonId;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.dungeonId=0;
         this._isInitialized=false;
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
         this.serializeAs_DungeonPartyFinderListenRequestMessage(output);
      }

      public function serializeAs_DungeonPartyFinderListenRequestMessage(output:IDataOutput) : void {
         if(this.dungeonId<0)
         {
            throw new Error("Forbidden value ("+this.dungeonId+") on element dungeonId.");
         }
         else
         {
            output.writeShort(this.dungeonId);
            return;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DungeonPartyFinderListenRequestMessage(input);
      }

      public function deserializeAs_DungeonPartyFinderListenRequestMessage(input:IDataInput) : void {
         this.dungeonId=input.readShort();
         if(this.dungeonId<0)
         {
            throw new Error("Forbidden value ("+this.dungeonId+") on element of DungeonPartyFinderListenRequestMessage.dungeonId.");
         }
         else
         {
            return;
         }
      }
   }

}