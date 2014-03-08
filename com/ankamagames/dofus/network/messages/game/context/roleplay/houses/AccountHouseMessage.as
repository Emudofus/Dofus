package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.house.AccountHouseInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AccountHouseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AccountHouseMessage() {
         this.houses = new Vector.<AccountHouseInformations>();
         super();
      }
      
      public static const protocolId:uint = 6315;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var houses:Vector.<AccountHouseInformations>;
      
      override public function getMessageId() : uint {
         return 6315;
      }
      
      public function initAccountHouseMessage(param1:Vector.<AccountHouseInformations>=null) : AccountHouseMessage {
         this.houses = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.houses = new Vector.<AccountHouseInformations>();
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
         this.serializeAs_AccountHouseMessage(param1);
      }
      
      public function serializeAs_AccountHouseMessage(param1:IDataOutput) : void {
         param1.writeShort(this.houses.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.houses.length)
         {
            (this.houses[_loc2_] as AccountHouseInformations).serializeAs_AccountHouseInformations(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AccountHouseMessage(param1);
      }
      
      public function deserializeAs_AccountHouseMessage(param1:IDataInput) : void {
         var _loc4_:AccountHouseInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new AccountHouseInformations();
            _loc4_.deserialize(param1);
            this.houses.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
