package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.DungeonPartyFinderPlayer;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DungeonPartyFinderRoomContentUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DungeonPartyFinderRoomContentUpdateMessage() {
         this.addedPlayers = new Vector.<DungeonPartyFinderPlayer>();
         this.removedPlayersIds = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6250;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      public var addedPlayers:Vector.<DungeonPartyFinderPlayer>;
      
      public var removedPlayersIds:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6250;
      }
      
      public function initDungeonPartyFinderRoomContentUpdateMessage(dungeonId:uint = 0, addedPlayers:Vector.<DungeonPartyFinderPlayer> = null, removedPlayersIds:Vector.<uint> = null) : DungeonPartyFinderRoomContentUpdateMessage {
         this.dungeonId = dungeonId;
         this.addedPlayers = addedPlayers;
         this.removedPlayersIds = removedPlayersIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
         this.addedPlayers = new Vector.<DungeonPartyFinderPlayer>();
         this.removedPlayersIds = new Vector.<uint>();
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
         this.serializeAs_DungeonPartyFinderRoomContentUpdateMessage(output);
      }
      
      public function serializeAs_DungeonPartyFinderRoomContentUpdateMessage(output:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeShort(this.dungeonId);
            output.writeShort(this.addedPlayers.length);
            _i2 = 0;
            while(_i2 < this.addedPlayers.length)
            {
               (this.addedPlayers[_i2] as DungeonPartyFinderPlayer).serializeAs_DungeonPartyFinderPlayer(output);
               _i2++;
            }
            output.writeShort(this.removedPlayersIds.length);
            _i3 = 0;
            while(_i3 < this.removedPlayersIds.length)
            {
               if(this.removedPlayersIds[_i3] < 0)
               {
                  throw new Error("Forbidden value (" + this.removedPlayersIds[_i3] + ") on element 3 (starting at 1) of removedPlayersIds.");
               }
               else
               {
                  output.writeInt(this.removedPlayersIds[_i3]);
                  _i3++;
                  continue;
               }
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DungeonPartyFinderRoomContentUpdateMessage(input);
      }
      
      public function deserializeAs_DungeonPartyFinderRoomContentUpdateMessage(input:IDataInput) : void {
         var _item2:DungeonPartyFinderPlayer = null;
         var _val3:uint = 0;
         this.dungeonId = input.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of DungeonPartyFinderRoomContentUpdateMessage.dungeonId.");
         }
         else
         {
            _addedPlayersLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _addedPlayersLen)
            {
               _item2 = new DungeonPartyFinderPlayer();
               _item2.deserialize(input);
               this.addedPlayers.push(_item2);
               _i2++;
            }
            _removedPlayersIdsLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _removedPlayersIdsLen)
            {
               _val3 = input.readInt();
               if(_val3 < 0)
               {
                  throw new Error("Forbidden value (" + _val3 + ") on elements of removedPlayersIds.");
               }
               else
               {
                  this.removedPlayersIds.push(_val3);
                  _i3++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
