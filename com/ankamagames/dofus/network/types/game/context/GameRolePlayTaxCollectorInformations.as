package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class GameRolePlayTaxCollectorInformations extends GameRolePlayActorInformations implements INetworkType
   {
         

      public function GameRolePlayTaxCollectorInformations() {
         this.guildIdentity=new GuildInformations();
         super();
      }

      public static const protocolId:uint = 148;

      public var firstNameId:uint = 0;

      public var lastNameId:uint = 0;

      public var guildIdentity:GuildInformations;

      public var guildLevel:uint = 0;

      public var taxCollectorAttack:int = 0;

      override public function getTypeId() : uint {
         return 148;
      }

      public function initGameRolePlayTaxCollectorInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, firstNameId:uint=0, lastNameId:uint=0, guildIdentity:GuildInformations=null, guildLevel:uint=0, taxCollectorAttack:int=0) : GameRolePlayTaxCollectorInformations {
         super.initGameRolePlayActorInformations(contextualId,look,disposition);
         this.firstNameId=firstNameId;
         this.lastNameId=lastNameId;
         this.guildIdentity=guildIdentity;
         this.guildLevel=guildLevel;
         this.taxCollectorAttack=taxCollectorAttack;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.firstNameId=0;
         this.lastNameId=0;
         this.guildIdentity=new GuildInformations();
         this.taxCollectorAttack=0;
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayTaxCollectorInformations(output);
      }

      public function serializeAs_GameRolePlayTaxCollectorInformations(output:IDataOutput) : void {
         super.serializeAs_GameRolePlayActorInformations(output);
         if(this.firstNameId<0)
         {
            throw new Error("Forbidden value ("+this.firstNameId+") on element firstNameId.");
         }
         else
         {
            output.writeShort(this.firstNameId);
            if(this.lastNameId<0)
            {
               throw new Error("Forbidden value ("+this.lastNameId+") on element lastNameId.");
            }
            else
            {
               output.writeShort(this.lastNameId);
               this.guildIdentity.serializeAs_GuildInformations(output);
               if((this.guildLevel>0)||(this.guildLevel<255))
               {
                  throw new Error("Forbidden value ("+this.guildLevel+") on element guildLevel.");
               }
               else
               {
                  output.writeByte(this.guildLevel);
                  output.writeInt(this.taxCollectorAttack);
                  return;
               }
            }
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayTaxCollectorInformations(input);
      }

      public function deserializeAs_GameRolePlayTaxCollectorInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.firstNameId=input.readShort();
         if(this.firstNameId<0)
         {
            throw new Error("Forbidden value ("+this.firstNameId+") on element of GameRolePlayTaxCollectorInformations.firstNameId.");
         }
         else
         {
            this.lastNameId=input.readShort();
            if(this.lastNameId<0)
            {
               throw new Error("Forbidden value ("+this.lastNameId+") on element of GameRolePlayTaxCollectorInformations.lastNameId.");
            }
            else
            {
               this.guildIdentity=new GuildInformations();
               this.guildIdentity.deserialize(input);
               this.guildLevel=input.readUnsignedByte();
               if((this.guildLevel>0)||(this.guildLevel<255))
               {
                  throw new Error("Forbidden value ("+this.guildLevel+") on element of GameRolePlayTaxCollectorInformations.guildLevel.");
               }
               else
               {
                  this.taxCollectorAttack=input.readInt();
                  return;
               }
            }
         }
      }
   }

}