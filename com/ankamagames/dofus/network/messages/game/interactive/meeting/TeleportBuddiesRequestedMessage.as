package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initTeleportBuddiesRequestedMessage(param1:uint=0, param2:uint=0, param3:Vector.<uint>=null) : TeleportBuddiesRequestedMessage {
         this.dungeonId = param1;
         this.inviterId = param2;
         this.invalidBuddiesIds = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
         this.inviterId = 0;
         this.invalidBuddiesIds = new Vector.<uint>();
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
         this.serializeAs_TeleportBuddiesRequestedMessage(param1);
      }
      
      public function serializeAs_TeleportBuddiesRequestedMessage(param1:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeShort(this.dungeonId);
            if(this.inviterId < 0)
            {
               throw new Error("Forbidden value (" + this.inviterId + ") on element inviterId.");
            }
            else
            {
               param1.writeInt(this.inviterId);
               param1.writeShort(this.invalidBuddiesIds.length);
               _loc2_ = 0;
               while(_loc2_ < this.invalidBuddiesIds.length)
               {
                  if(this.invalidBuddiesIds[_loc2_] < 0)
                  {
                     throw new Error("Forbidden value (" + this.invalidBuddiesIds[_loc2_] + ") on element 3 (starting at 1) of invalidBuddiesIds.");
                  }
                  else
                  {
                     param1.writeInt(this.invalidBuddiesIds[_loc2_]);
                     _loc2_++;
                     continue;
                  }
               }
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TeleportBuddiesRequestedMessage(param1);
      }
      
      public function deserializeAs_TeleportBuddiesRequestedMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         this.dungeonId = param1.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportBuddiesRequestedMessage.dungeonId.");
         }
         else
         {
            this.inviterId = param1.readInt();
            if(this.inviterId < 0)
            {
               throw new Error("Forbidden value (" + this.inviterId + ") on element of TeleportBuddiesRequestedMessage.inviterId.");
            }
            else
            {
               _loc2_ = param1.readUnsignedShort();
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = param1.readInt();
                  if(_loc4_ < 0)
                  {
                     throw new Error("Forbidden value (" + _loc4_ + ") on elements of invalidBuddiesIds.");
                  }
                  else
                  {
                     this.invalidBuddiesIds.push(_loc4_);
                     _loc3_++;
                     continue;
                  }
               }
               return;
            }
         }
      }
   }
}
