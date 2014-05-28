package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initAccountHouseMessage(houses:Vector.<AccountHouseInformations> = null) : AccountHouseMessage {
         this.houses = houses;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.houses = new Vector.<AccountHouseInformations>();
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
         this.serializeAs_AccountHouseMessage(output);
      }
      
      public function serializeAs_AccountHouseMessage(output:IDataOutput) : void {
         output.writeShort(this.houses.length);
         var _i1:uint = 0;
         while(_i1 < this.houses.length)
         {
            (this.houses[_i1] as AccountHouseInformations).serializeAs_AccountHouseInformations(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AccountHouseMessage(input);
      }
      
      public function deserializeAs_AccountHouseMessage(input:IDataInput) : void {
         var _item1:AccountHouseInformations = null;
         var _housesLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _housesLen)
         {
            _item1 = new AccountHouseInformations();
            _item1.deserialize(input);
            this.houses.push(_item1);
            _i1++;
         }
      }
   }
}
