package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TeleportBuddiesRequestedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportBuddiesRequestedMessage() {
         this.invalidBuddiesIds = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6302;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      public var inviterId:uint = 0;
      
      public var invalidBuddiesIds:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6302;
      }
      
      public function initTeleportBuddiesRequestedMessage(dungeonId:uint=0, inviterId:uint=0, invalidBuddiesIds:Vector.<uint>=null) : TeleportBuddiesRequestedMessage {
         this.dungeonId = dungeonId;
         this.inviterId = inviterId;
         this.invalidBuddiesIds = invalidBuddiesIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
         this.inviterId = 0;
         this.invalidBuddiesIds = new Vector.<uint>();
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
         this.serializeAs_TeleportBuddiesRequestedMessage(output);
      }
      
      public function serializeAs_TeleportBuddiesRequestedMessage(output:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeShort(this.dungeonId);
            if(this.inviterId < 0)
            {
               throw new Error("Forbidden value (" + this.inviterId + ") on element inviterId.");
            }
            else
            {
               output.writeInt(this.inviterId);
               output.writeShort(this.invalidBuddiesIds.length);
               _i3 = 0;
               while(_i3 < this.invalidBuddiesIds.length)
               {
                  if(this.invalidBuddiesIds[_i3] < 0)
                  {
                     throw new Error("Forbidden value (" + this.invalidBuddiesIds[_i3] + ") on element 3 (starting at 1) of invalidBuddiesIds.");
                  }
                  else
                  {
                     output.writeInt(this.invalidBuddiesIds[_i3]);
                     _i3++;
                     continue;
                  }
               }
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TeleportBuddiesRequestedMessage(input);
      }
      
      public function deserializeAs_TeleportBuddiesRequestedMessage(input:IDataInput) : void {
         var _val3:uint = 0;
         this.dungeonId = input.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportBuddiesRequestedMessage.dungeonId.");
         }
         else
         {
            this.inviterId = input.readInt();
            if(this.inviterId < 0)
            {
               throw new Error("Forbidden value (" + this.inviterId + ") on element of TeleportBuddiesRequestedMessage.inviterId.");
            }
            else
            {
               _invalidBuddiesIdsLen = input.readUnsignedShort();
               _i3 = 0;
               while(_i3 < _invalidBuddiesIdsLen)
               {
                  _val3 = input.readInt();
                  if(_val3 < 0)
                  {
                     throw new Error("Forbidden value (" + _val3 + ") on elements of invalidBuddiesIds.");
                  }
                  else
                  {
                     this.invalidBuddiesIds.push(_val3);
                     _i3++;
                     continue;
                  }
               }
               return;
            }
         }
      }
   }
}
