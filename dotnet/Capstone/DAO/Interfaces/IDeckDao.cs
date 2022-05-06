using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO.Interfaces
{
    public interface IDeckDao
    {
        Deck AddDeck(int userId, string deckName, string deckDescription);

        Deck GetDeck(int deckId);

        List<Deck> MyDecks(int userId);
        Deck UpdateDeck(int deckId, string deckName, string deckDescription);
        bool DeleteDeck(int deckId);

        List<Deck> GetPublicDecks();

        List<Deck> GetDecksForStudy(int userId);
        bool SubmitDeckForAdminApproval(int deckId);
        List<Deck> GetDecksSubmittedForApproval();
        bool AdminApproveDeck(int subId);
        bool AdminDenyDeck(int subId);

    }
}
