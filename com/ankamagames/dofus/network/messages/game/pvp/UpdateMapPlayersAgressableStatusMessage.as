package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class UpdateMapPlayersAgressableStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function UpdateMapPlayersAgressableStatusMessage() {
         this.playerIds = new Vector.<uint>();
         this.enable = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6454;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var playerIds:Vector.<uint>;
      
      public var enable:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6454;
      }
      
      public function initUpdateMapPlayersAgressableStatusMessage(playerIds:Vector.<uint> = null, enable:Vector.<uint> = null) : UpdateMapPlayersAgressableStatusMessage {
         this.playerIds = playerIds;
         this.enable = enable;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playerIds = new Vector.<uint>();
         this.enable = new Vector.<uint>();
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
         this.serializeAs_UpdateMapPlayersAgressableStatusMessage(output);
      }
      
      public function serializeAs_UpdateMapPlayersAgressableStatusMessage(output:IDataOutput) : void {
         output.writeShort(this.playerIds.length);
         var _i1:uint = 0;
         while(_i1 < this.playerIds.length)
         {
            if(this.playerIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.playerIds[_i1] + ") on element 1 (starting at 1) of playerIds.");
            }
            else
            {
               output.writeInt(this.playerIds[_i1]);
               _i1++;
               continue;
            }
         }
         output.writeShort(this.enable.length);
         var _i2:uint = 0;
         while(_i2 < this.enable.length)
         {
            output.writeByte(this.enable[_i2]);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_UpdateMapPlayersAgressableStatusMessage(input);
      }
      
      public function deserializeAs_UpdateMapPlayersAgressableStatusMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _playerIdsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _playerIdsLen)
         {
            _val1 = input.readInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of playerIds.");
            }
            else
            {
               this.playerIds.push(_val1);
               _i1++;
               continue;
            }
         }
         var _enableLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _enableLen)
         {
            _val2 = input.readByte();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of enable.");
            }
            else
            {
               this.enable.push(_val2);
               _i2++;
               continue;
            }
         }
      }
   }
}
