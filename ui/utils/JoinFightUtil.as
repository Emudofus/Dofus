package utils
{
    import d2actions.GuildFightJoinRequest;
    import d2actions.PrismFightJoinLeaveRequest;
    import d2actions.GuildFightLeaveRequest;
    import d2actions.GuildFightTakePlaceRequest;
    import d2actions.PrismFightSwapRequest;
    import d2network.CharacterMinimalPlusLookInformations;

    public class JoinFightUtil 
    {

        private static const TYPE_TAX_COLLECTOR:int = 0;
        private static const TYPE_PRISM:int = 1;


        public static function join(pFightType:int, pFightId:int):void
        {
            if (Api.social.isPlayerDefender(pFightType, Api.player.id(), pFightId))
            {
                leave(pFightType, pFightId);
            }
            else
            {
                if (pFightType == TYPE_TAX_COLLECTOR)
                {
                    Api.system.sendAction(new GuildFightJoinRequest(pFightId));
                }
                else
                {
                    if (pFightType == TYPE_PRISM)
                    {
                        Api.system.sendAction(new PrismFightJoinLeaveRequest(pFightId, true));
                    };
                };
            };
        }

        public static function leave(pFightType:int, pFightId:int):void
        {
            if (pFightType == TYPE_TAX_COLLECTOR)
            {
                Api.system.sendAction(new GuildFightLeaveRequest(pFightId, Api.player.id()));
            }
            else
            {
                if (pFightType == TYPE_PRISM)
                {
                    Api.system.sendAction(new PrismFightJoinLeaveRequest(pFightId, false));
                };
            };
        }

        public static function swapPlaces(pFightType:int, pFightId:int, pTarget:CharacterMinimalPlusLookInformations):void
        {
            if (pFightType == TYPE_TAX_COLLECTOR)
            {
                Api.system.sendAction(new GuildFightTakePlaceRequest(pFightId, pTarget.id));
            }
            else
            {
                if (pFightType == TYPE_PRISM)
                {
                    Api.system.sendAction(new PrismFightSwapRequest(pFightId, pTarget.id));
                };
            };
        }


    }
}//package utils

