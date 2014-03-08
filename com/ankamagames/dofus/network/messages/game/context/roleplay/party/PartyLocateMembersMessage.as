package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberGeoPosition;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyLocateMembersMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyLocateMembersMessage() {
         this.geopositions = new Vector.<PartyMemberGeoPosition>();
         super();
      }
      
      public static const protocolId:uint = 5595;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var geopositions:Vector.<PartyMemberGeoPosition>;
      
      override public function getMessageId() : uint {
         return 5595;
      }
      
      public function initPartyLocateMembersMessage(param1:uint=0, param2:Vector.<PartyMemberGeoPosition>=null) : PartyLocateMembersMessage {
         super.initAbstractPartyMessage(param1);
         this.geopositions = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.geopositions = new Vector.<PartyMemberGeoPosition>();
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
         this.serializeAs_PartyLocateMembersMessage(param1);
      }
      
      public function serializeAs_PartyLocateMembersMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(param1);
         param1.writeShort(this.geopositions.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.geopositions.length)
         {
            (this.geopositions[_loc2_] as PartyMemberGeoPosition).serializeAs_PartyMemberGeoPosition(param1);
            _loc2_++;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyLocateMembersMessage(param1);
      }
      
      public function deserializeAs_PartyLocateMembersMessage(param1:IDataInput) : void {
         var _loc4_:PartyMemberGeoPosition = null;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new PartyMemberGeoPosition();
            _loc4_.deserialize(param1);
            this.geopositions.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
