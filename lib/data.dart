import 'dart:math';

class Data {
  static final List<Map<String, dynamic>> novels = [
    {
      "title": "To Kill a Mockingbird",
      "author": "Harper Lee",
      "cover": "https://covers.openlibrary.org/b/id/8225261-L.jpg",
    },
    {
      "title": "1984",
      "author": "George Orwell",
      "cover": "https://covers.openlibrary.org/b/id/7222246-L.jpg",
    },
    {
      "title": "Pride and Prejudice",
      "author": "Jane Austen",
      "cover": "https://covers.openlibrary.org/b/id/8231991-L.jpg",
    },
    {
      "title": "The Great Gatsby",
      "author": "F. Scott Fitzgerald",
      "cover": "https://covers.openlibrary.org/b/id/7222161-L.jpg",
    },
    {
      "title": "Moby-Dick",
      "author": "Herman Melville",
      "cover": "https://covers.openlibrary.org/b/id/8100920-L.jpg",
    },
    {
      "title": "War and Peace",
      "author": "Leo Tolstoy",
      "cover": "https://covers.openlibrary.org/b/id/7235237-L.jpg",
    },
    {
      "title": "Crime and Punishment",
      "author": "Fyodor Dostoevsky",
      "cover": "https://covers.openlibrary.org/b/id/8319256-L.jpg",
    },
    {
      "title": "Jane Eyre",
      "author": "Charlotte Brontë",
      "cover": "https://covers.openlibrary.org/b/id/8081531-L.jpg",
    },
    {
      "title": "Wuthering Heights",
      "author": "Emily Brontë",
      "cover": "https://covers.openlibrary.org/b/id/8281996-L.jpg",
    },
    {
      "title": "The Catcher in the Rye",
      "author": "J.D. Salinger",
      "cover": "https://covers.openlibrary.org/b/id/8231856-L.jpg",
    },
    {
      "title": "The Hobbit",
      "author": "J.R.R. Tolkien",
      "cover": "https://covers.openlibrary.org/b/id/6979861-L.jpg",
    },
    {
      "title": "Fahrenheit 451",
      "author": "Ray Bradbury",
      "cover": "https://covers.openlibrary.org/b/id/7984916-L.jpg",
    },
    {
      "title": "Brave New World",
      "author": "Aldous Huxley",
      "cover": "https://covers.openlibrary.org/b/id/7222241-L.jpg",
    },
    {
      "title": "The Picture of Dorian Gray",
      "author": "Oscar Wilde",
      "cover": "https://covers.openlibrary.org/b/id/8085457-L.jpg",
    },
    {
      "title": "Little Women",
      "author": "Louisa May Alcott",
      "cover": "https://covers.openlibrary.org/b/id/8235087-L.jpg",
    },
    {
      "title": "Dracula",
      "author": "Bram Stoker",
      "cover": "https://covers.openlibrary.org/b/id/8114153-L.jpg",
    },
    {
      "title": "Frankenstein",
      "author": "Mary Shelley",
      "cover": "https://covers.openlibrary.org/b/id/8104483-L.jpg",
    },
    {
      "title": "The Alchemist",
      "author": "Paulo Coelho",
      "cover": "https://covers.openlibrary.org/b/id/8235116-L.jpg",
    },
    {
      "title": "The Kite Runner",
      "author": "Khaled Hosseini",
      "cover": "https://covers.openlibrary.org/b/id/8244143-L.jpg",
    },
    {
      "title": "Life of Pi",
      "author": "Yann Martel",
      "cover": "https://covers.openlibrary.org/b/id/8281991-L.jpg",
    },
  ];

  static final List<Map<String, dynamic>> popularSongs = [
    {
      "title": "Blinding Lights",
      "artist": "The Weeknd",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/0/09/The_Weeknd_-_Blinding_Lights.png",
    },
    {
      "title": "Shape of You",
      "artist": "Ed Sheeran",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/4/45/Shape_Of_You_%28Official_Single_Cover%29_by_Ed_Sheeran.png",
    },
    {
      "title": "Levitating",
      "artist": "Dua Lipa",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/1/18/Dua_Lipa_-_Levitating.png",
    },
    {
      "title": "Stay",
      "artist": "The Kid LAROI & Justin Bieber",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/9/9a/The_Kid_Laroi_and_Justin_Bieber_-_Stay.png",
    },
    {
      "title": "As It Was",
      "artist": "Harry Styles",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/9/9e/Harry_Styles_-_As_It_Was.png",
    },
    {
      "title": "Bad Habits",
      "artist": "Ed Sheeran",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/6/68/Ed_Sheeran_-_Bad_Habits.png",
    },
    {
      "title": "Peaches",
      "artist": "Justin Bieber ft. Daniel Caesar, Giveon",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/3/33/Peaches_by_Justin_Bieber.png",
    },
    {
      "title": "Watermelon Sugar",
      "artist": "Harry Styles",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/9/9c/Harry_Styles_-_Watermelon_Sugar.png",
    },
    {
      "title": "Senorita",
      "artist": "Shawn Mendes & Camila Cabello",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/2/27/Shawn_Mendes_and_Camila_Cabello_-_Se%C3%B1orita.png",
    },
    {
      "title": "Uptown Funk",
      "artist": "Mark Ronson ft. Bruno Mars",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/b/b6/UptownFunkSingleCover.png",
    },
    {
      "title": "Happier Than Ever",
      "artist": "Billie Eilish",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/f/f5/Billie_Eilish_-_Happier_Than_Ever.png",
    },
    {
      "title": "Easy On Me",
      "artist": "Adele",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/3/3d/Adele_-_Easy_on_Me.png",
    },
    {
      "title": "Drivers License",
      "artist": "Olivia Rodrigo",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/0/0a/Olivia_Rodrigo_-_Drivers_License.png",
    },
    {
      "title": "Industry Baby",
      "artist": "Lil Nas X & Jack Harlow",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/8/8e/Lil_Nas_X_and_Jack_Harlow_-_Industry_Baby.png",
    },
    {
      "title": "Anti-Hero",
      "artist": "Taylor Swift",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/8/8e/Taylor_Swift_-_Anti-Hero.png",
    },
    {
      "title": "Butter",
      "artist": "BTS",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/e/e3/BTS_-_Butter.png",
    },
    {
      "title": "Flowers",
      "artist": "Miley Cyrus",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/0/0b/Miley_Cyrus_-_Flowers.png",
    },
    {
      "title": "Shivers",
      "artist": "Ed Sheeran",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/3/3d/Ed_Sheeran_-_Shivers.png",
    },
    {
      "title": "Save Your Tears",
      "artist": "The Weeknd",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/d/d6/The_Weeknd_-_Save_Your_Tears.png",
    },
    {
      "title": "Someone You Loved",
      "artist": "Lewis Capaldi",
      "cover":
          "https://upload.wikimedia.org/wikipedia/en/7/74/Lewis_Capaldi_-_Someone_You_Loved.png",
    },
  ];

  static List<Map<String, dynamic>> get_shuffled_novels() {
    novels.shuffle(Random());

    return novels;
  }

  static List<Map<String, dynamic>> get_shuffled_songs() {
    popularSongs.shuffle(Random());

    return popularSongs;
  }
}
