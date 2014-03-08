package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceTaxCollectorDialogQuestionExtendedMessage extends TaxCollectorDialogQuestionExtendedMessage implements INetworkMessage
   {
      
      public function AllianceTaxCollectorDialogQuestionExtendedMessage() {
         this.alliance = new BasicNamedAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 6445;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var alliance:BasicNamedAllianceInformations;
      
      override public function getMessageId() : uint {
         return 6445;
      }
      
      public function initAllianceTaxCollectorDialogQuestionExtendedMessage(param1:BasicGuildInformations=null, param2:uint=0, param3:uint=0, param4:uint=0, param5:uint=0, param6:int=0, param7:uint=0, param8:Number=0, param9:uint=0, param10:uint=0, param11:BasicNamedAllianceInformations=null) : AllianceTaxCollectorDialogQuestionExtendedMessage {
         super.initTaxCollectorDialogQuestionExtendedMessage(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         this.alliance = param11;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.alliance = new BasicNamedAllianceInformations();
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
         this.serializeAs_AllianceTaxCollectorDialogQuestionExtendedMessage(param1);
      }
      
      public function serializeAs_AllianceTaxCollectorDialogQuestionExtendedMessage(param1:IDataOutput) : void {
         super.serializeAs_TaxCollectorDialogQuestionExtendedMessage(param1);
         this.alliance.serializeAs_BasicNamedAllianceInformations(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceTaxCollectorDialogQuestionExtendedMessage(param1);
      }
      
      public function deserializeAs_AllianceTaxCollectorDialogQuestionExtendedMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.alliance = new BasicNamedAllianceInformations();
         this.alliance.deserialize(param1);
      }
   }
}
