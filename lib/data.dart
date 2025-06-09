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

  static final List<Map<String, String>> depressionArticles = [
    {
      "title": "10 Small Daily Habits to Fight Depression",
      "content":
          "Start your day with a 5-minute gratitude list. Move your body with light exercise. Limit your social media exposure. Eat balanced meals. Hydrate. Go outside. Practice deep breathing. Sleep on time. Celebrate small wins. Repeat daily.",
    },
    {
      "title": "Talking Heals: The Power of Sharing",
      "content":
          "Talking to a trusted friend, counselor, or even journaling can ease emotional burdens. Expression helps release pent-up emotions and reduces the feeling of being trapped.",
    },
    {
      "title": "Exercise Your Way Out of Darkness",
      "content":
          "Regular physical activity releases endorphins, the body’s natural mood boosters. A brisk 20-minute walk, yoga, or dancing can significantly improve your mood over time.",
    },
    {
      "title": "Why Sleep Is the Secret Weapon",
      "content":
          "Consistent and quality sleep is critical for mental health. Establish a bedtime routine, avoid screens before bed, and wake up at the same time every day—even on weekends.",
    },
    {
      "title": "Social Connection: The Antidote to Isolation",
      "content":
          "Even if you don’t feel like it, spending time with people who care about you makes a difference. A call, a coffee meet-up, or group activity helps reduce feelings of loneliness.",
    },
    {
      "title": "Rewire Your Brain with Positivity",
      "content":
          "Your thoughts shape your reality. Replace 'I can't' with 'I'm trying.' Practice daily affirmations and challenge negative beliefs through cognitive-behavioral techniques.",
    },
    {
      "title": "The Healing Power of Nature",
      "content":
          "Spending time in green spaces, forests, or even tending a small garden can lift your spirits. Nature exposure reduces cortisol and helps clear the mind.",
    },
    {
      "title": "Nutrition and Depression: What's the Link?",
      "content":
          "What you eat impacts how you feel. Omega-3s, vitamin D, and avoiding excess sugar and caffeine are linked to improved mood. Eat mindfully and nourish your brain.",
    },
    {
      "title": "Mindfulness and Meditation for Mental Clarity",
      "content":
          "Practicing mindfulness helps you stay present. Meditation, even just 5 minutes a day, reduces stress and improves emotional regulation. Try guided meditations or apps.",
    },
    {
      "title": "Set Goals—Even Tiny Ones",
      "content":
          "Depression can make everything feel overwhelming. Break tasks into small steps. Celebrate each one. Progress, no matter how small, builds confidence and hope.",
    },
    {
      "title": "Volunteer and Find Purpose",
      "content":
          "Helping others gives you a sense of value and connection. Volunteering, mentoring, or even small acts of kindness can shift focus outward and spark joy.",
    },
    {
      "title": "Limit Alcohol and Avoid Drugs",
      "content":
          "Substances might numb pain temporarily but worsen depression in the long run. Seek healthier coping methods and get professional help if needed.",
    },
    {
      "title": "You Are Not Alone: When to Seek Professional Help",
      "content":
          "Therapists, psychologists, and support groups can help you feel understood and develop personalized recovery plans. Asking for help is strength—not weakness.",
    },
    {
      "title": "Digital Detox: Unplug to Reconnect",
      "content":
          "Constant comparison on social media can fuel sadness. Try a weekend detox, disable notifications, or replace screen time with real-world activities.",
    },
    {
      "title": "Pet Therapy: Let Animals Help You Heal",
      "content":
          "Pets offer unconditional love and companionship. Studies show they reduce stress and bring emotional stability. Even brief interactions can elevate mood.",
    },
    {
      "title": "Laughter is Medicine",
      "content":
          "Watch a comedy, talk to a funny friend, or join a laughter yoga session. Laughter releases endorphins and shifts mental energy toward positivity.",
    },
    {
      "title": "Music and Mood: Create a Healing Playlist",
      "content":
          "Music can be incredibly therapeutic. Make a playlist of songs that make you feel calm, empowered, or hopeful. Let sound be your sanctuary.",
    },
    {
      "title": "Learn Something New to Break the Cycle",
      "content":
          "Learning a new skill activates new neural pathways, gives a sense of accomplishment, and distracts from rumination. Try painting, coding, or cooking.",
    },
    {
      "title": "Create a Safe Routine",
      "content":
          "Structure combats chaos. A daily routine—wake, eat, move, rest—gives you something predictable and helps restore a sense of control.",
    },
    {
      "title": "Forgive Yourself and Let Go",
      "content":
          "Self-blame traps you. Practice self-compassion. Understand your past, but don’t live in it. Forgiveness is freedom—and it starts with you.",
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

  static List<Map<String, dynamic>> get_shuffled_articals() {
    // For demonstration, returning an empty list as no articles are defined

    depressionArticles.shuffle(Random());
    return depressionArticles;
  }
}
