package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class NamedPartyTeam extends Object implements INetworkType
   {
      
      public function NamedPartyTeam() {
         super();
      }
      
      public static const protocolId:uint = 469;
      
      public var teamId:uint = 2;
      
      public var partyName:String = "";
      
      public function getTypeId() : uint {
         return 469;
      }
      
      public function initNamedPartyTeam(teamId:uint = 2, partyName:String = "") : NamedPartyTeam {
         this.teamId = teamId;
         this.partyName = partyName;
         return this;
      }
      
      public function reset() : void {
         this.teamId = 2;
         this.partyName = "";
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_NamedPartyTeam(output);
      }
      
      public function serializeAs_NamedPartyTeam(output:IDataOutput) : void {
         output.writeByte(this.teamId);
         output.writeUTF(this.partyName);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NamedPartyTeam(input);
      }
      
      public function deserializeAs_NamedPartyTeam(input:IDataInput) : void {
         this.teamId = input.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of NamedPartyTeam.teamId.");
         }
         else
         {
            this.partyName = input.readUTF();
            return;
         }
      }
   }
}
