package com.ankamagames.dofusModuleLibrary.utils
{
    public class PlayerGuildRights 
    {


        public static function isBoss(pPlayerRights:uint):Boolean
        {
            return (((1 & pPlayerRights) > 0));
        }

        public static function manageGuildBoosts(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((2 & pPlayerRights) > 0))));
        }

        public static function manageRights(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((4 & pPlayerRights) > 0))));
        }

        public static function inviteNewMembers(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((8 & pPlayerRights) > 0))));
        }

        public static function banMembers(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((16 & pPlayerRights) > 0))));
        }

        public static function manageXPContribution(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((32 & pPlayerRights) > 0))));
        }

        public static function manageRanks(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((64 & pPlayerRights) > 0))));
        }

        public static function manageMyXpContribution(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((128 & pPlayerRights) > 0))));
        }

        public static function hireTaxCollector(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((0x0100 & pPlayerRights) > 0))));
        }

        public static function collect(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((0x0200 & pPlayerRights) > 0))));
        }

        public static function manageLightRights(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((0x0400 & pPlayerRights) > 0))));
        }

        public static function useFarms(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((0x1000 & pPlayerRights) > 0))));
        }

        public static function organizeFarms(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((0x2000 & pPlayerRights) > 0))));
        }

        public static function takeOthersRidesInFarm(pPlayerRights:uint):Boolean
        {
            return (((isBoss(pPlayerRights)) || (((0x4000 & pPlayerRights) > 0))));
        }


    }
}//package com.ankamagames.dofusModuleLibrary.utils

