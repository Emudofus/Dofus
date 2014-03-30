package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class KohUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function KohUpdateMessage() {
         this.alliances = new Vector.<AllianceInformations>();
         this.allianceNbMembers = new Vector.<uint>();
         this.allianceRoundWeigth = new Vector.<uint>();
         this.allianceMatchScore = new Vector.<uint>();
         this.allianceMapWinner = new BasicAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 6439;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var alliances:Vector.<AllianceInformations>;
      
      public var allianceNbMembers:Vector.<uint>;
      
      public var allianceRoundWeigth:Vector.<uint>;
      
      public var allianceMatchScore:Vector.<uint>;
      
      public var allianceMapWinner:BasicAllianceInformations;
      
      public var allianceMapWinnerScore:uint = 0;
      
      public var allianceMapMyAllianceScore:uint = 0;
      
      public var nextTickTime:Number = 0;
      
      override public function getMessageId() : uint {
         return 6439;
      }
      
      public function initKohUpdateMessage(alliances:Vector.<AllianceInformations>=null, allianceNbMembers:Vector.<uint>=null, allianceRoundWeigth:Vector.<uint>=null, allianceMatchScore:Vector.<uint>=null, allianceMapWinner:BasicAllianceInformations=null, allianceMapWinnerScore:uint=0, allianceMapMyAllianceScore:uint=0, nextTickTime:Number=0) : KohUpdateMessage {
         this.alliances = alliances;
         this.allianceNbMembers = allianceNbMembers;
         this.allianceRoundWeigth = allianceRoundWeigth;
         this.allianceMatchScore = allianceMatchScore;
         this.allianceMapWinner = allianceMapWinner;
         this.allianceMapWinnerScore = allianceMapWinnerScore;
         this.allianceMapMyAllianceScore = allianceMapMyAllianceScore;
         this.nextTickTime = nextTickTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.alliances = new Vector.<AllianceInformations>();
         this.allianceNbMembers = new Vector.<uint>();
         this.allianceRoundWeigth = new Vector.<uint>();
         this.allianceMatchScore = new Vector.<uint>();
         this.allianceMapWinner = new BasicAllianceInformations();
         this.allianceMapMyAllianceScore = 0;
         this.nextTickTime = 0;
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
         this.serializeAs_KohUpdateMessage(output);
      }
      
      public function serializeAs_KohUpdateMessage(output:IDataOutput) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_KohUpdateMessage(input);
      }
      
      public function deserializeAs_KohUpdateMessage(input:IDataInput) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
