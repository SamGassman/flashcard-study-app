using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO.Interfaces
{
    public interface ICardDao
    {
        Card AddCard(string cardFront, string cardBack, string cardImage, int userId, int deckId, string[] tags);

        Card GetCard(int cardId);

        bool AddCardToDeck(int cardId, int deckId);

        List<Card> GetCardsInDeck(int deckId);

        bool DeleteCardFromDeck(int cardId, int deckId);

        Card UpdateCard(string cardFront, string cardBack, string cardImage, int cardId, string[] tags);

        List<Card> GetCardsByUser(int userId);
        List<Card> GetPublicCards();
        List<Card> GetCardsForSearch(int userId);

    }
}
