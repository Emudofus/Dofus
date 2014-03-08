package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ZaapListMessage extends TeleportDestinationsListMessage implements INetworkMessage
   {
      
      public function ZaapListMessage() {
         super();
      }
      
      public static const protocolId:uint = 1604;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var spawnMapId:uint = 0;
      
      override public function getMessageId() : uint {
         return 1604;
      }
      
      public function initZaapListMessage(param1:uint=0, param2:Vector.<uint>=null, param3:Vector.<uint>=null, param4:Vector.<uint>=null, param5:Vector.<uint>=null, param6:uint=0) : ZaapListMessage {
         super.initTeleportDestinationsListMessage(param1,param2,param3,param4,param5);
         this.spawnMapId = param6;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.spawnMapId = 0;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ZaapListMessage(param1);
      }
      
      public function serializeAs_ZaapListMessage(param1:IDataOutput) : void {
         super.serializeAs_TeleportDestinationsListMessage(param1);
         if(this.spawnMapId < 0)
         {
            throw new Error("Forbidden value (" + this.spawnMapId + ") on element spawnMapId.");
         }
         else
         {
            param1.writeInt(this.spawnMapId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ZaapListMessage(param1);
      }
      
      public function deserializeAs_ZaapListMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.spawnMapId = param1.readInt();
         if(this.spawnMapId < 0)
         {
            throw new Error("Forbidden value (" + this.spawnMapId + ") on element of ZaapListMessage.spawnMapId.");
         }
         else
         {
            return;
         }
      }
   }
}
