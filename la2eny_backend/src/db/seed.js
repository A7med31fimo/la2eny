'use strict';

require('dotenv').config();
const { getDb } = require('./database');

const categories = [
  { id: 1,  name_ar: 'مطاعم',          name_en: 'Restaurants',          icon: '🍽️' },
  { id: 2,  name_ar: 'مقاهي',          name_en: 'Cafés',                icon: '☕'  },
  { id: 3,  name_ar: 'حلويات ومخابز',  name_en: 'Desserts & Bakeries',  icon: '🧁' },
  { id: 4,  name_ar: 'صيدليات',        name_en: 'Pharmacies',            icon: '💊' },
  { id: 5,  name_ar: 'سوبرماركت',      name_en: 'Supermarkets',          icon: '🛒' },
  { id: 6,  name_ar: 'مطاعم يابانية',  name_en: 'Japanese',              icon: '🍣' },
  { id: 7,  name_ar: 'مطاعم إيطالية', name_en: 'Italian',               icon: '🍕' },
  { id: 8,  name_ar: 'وجبات سريعة',   name_en: 'Fast Food',             icon: '🍔' },
  { id: 9,  name_ar: 'مطاعم هندية',   name_en: 'Indian',                icon: '🍛' },
  { id: 10, name_ar: 'مطاعم عربية',   name_en: 'Arabic',                icon: '🥙' },
];

const places = [
  {
    id: 1, name_ar: 'مطعم البيك', name_en: 'Al Baik',
    description_ar: 'أشهر مطعم وجبات سريعة في المملكة العربية السعودية، يقدم الدجاج المقلي الهش مع الصلصة السرية المميزة.',
    description_en: "Saudi Arabia's most iconic fast-food chain, famous for crispy fried chicken with a legendary secret sauce.",
    address_ar: 'طريق الملك فهد، الرياض', address_en: 'King Fahad Road, Riyadh',
    latitude: 24.7136, longitude: 46.6753, phone: '+966112345678', website: 'https://albaik.com',
    rating: 4.7, review_count: 3200, price_level: 1, is_active: 1,
    created_at: '2020-01-01T00:00:00Z', updated_at: '2024-06-01T10:00:00Z',
    categories: [8, 1],
    working_hours: [
      { day_of_week: 0, open_time: '10:00', close_time: '02:00', is_closed: 0 },
      { day_of_week: 1, open_time: '10:00', close_time: '02:00', is_closed: 0 },
      { day_of_week: 2, open_time: '10:00', close_time: '02:00', is_closed: 0 },
      { day_of_week: 3, open_time: '10:00', close_time: '02:00', is_closed: 0 },
      { day_of_week: 4, open_time: '10:00', close_time: '03:00', is_closed: 0 },
      { day_of_week: 5, open_time: '10:00', close_time: '03:00', is_closed: 0 },
      { day_of_week: 6, open_time: '10:00', close_time: '02:00', is_closed: 0 },
    ],
    images: [
      { url: 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=800', is_primary: 1, sort_order: 0 },
      { url: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800', is_primary: 0, sort_order: 1 },
    ],
    social_links: [{ platform: 'instagram', url: 'https://instagram.com/albaik' }],
  },
  {
    id: 2, name_ar: 'ستاربكس طريق التخصصي', name_en: 'Starbucks Takhassousi',
    description_ar: 'فرع ستاربكس المميز في قلب الرياض مع أجواء هادئة مثالية للعمل والاجتماعات.',
    description_en: 'A premium Starbucks branch in central Riyadh with a calm ambience ideal for working and meetings.',
    address_ar: 'طريق التخصصي، الرياض', address_en: 'Takhassousi Road, Riyadh',
    latitude: 24.7200, longitude: 46.6400, phone: '+966112345679', website: 'https://starbucks.com.sa',
    rating: 4.4, review_count: 1800, price_level: 3, is_active: 1,
    created_at: '2019-05-01T00:00:00Z', updated_at: '2024-06-01T10:00:00Z',
    categories: [2],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '06:30', close_time: '01:00', is_closed: 0 }))
      .concat([4,5].map(d => ({ day_of_week: d, open_time: '06:30', close_time: '02:00', is_closed: 0 })))
      .concat([{ day_of_week: 6, open_time: '06:30', close_time: '01:00', is_closed: 0 }]),
    images: [
      { url: 'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?w=800', is_primary: 1, sort_order: 0 },
      { url: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800', is_primary: 0, sort_order: 1 },
    ],
    social_links: [
      { platform: 'instagram', url: 'https://instagram.com/starbucksksa' },
      { platform: 'twitter',   url: 'https://twitter.com/StarbucksKSA' },
    ],
  },
  {
    id: 3, name_ar: 'مطعم ياسوداه للسوشي', name_en: 'Yasuda Sushi',
    description_ar: 'تجربة سوشي أصيلة بأيدي طهاة يابانيين محترفين، مع مكونات طازجة تصل يومياً.',
    description_en: 'Authentic sushi experience crafted by professional Japanese chefs, with fresh ingredients delivered daily.',
    address_ar: 'حي العليا، الرياض', address_en: 'Al Olaya District, Riyadh',
    latitude: 24.6900, longitude: 46.6830, phone: '+966112345680', website: 'https://yasuda-sushi.sa',
    rating: 4.8, review_count: 980, price_level: 4, is_active: 1,
    created_at: '2021-03-15T00:00:00Z', updated_at: '2024-06-10T08:00:00Z',
    categories: [6, 1],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '12:00', close_time: '23:00', is_closed: 0 }))
      .concat([4,5].map(d => ({ day_of_week: d, open_time: d===5?'13:00':'12:00', close_time: '00:00', is_closed: 0 })))
      .concat([{ day_of_week: 6, open_time: '12:00', close_time: '23:00', is_closed: 0 }]),
    images: [
      { url: 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=800', is_primary: 1, sort_order: 0 },
      { url: 'https://images.unsplash.com/photo-1559410545-0bdcd187e0a6?w=800', is_primary: 0, sort_order: 1 },
    ],
    social_links: [{ platform: 'instagram', url: 'https://instagram.com/yasudasushi' }],
  },
  {
    id: 4, name_ar: 'برجر بوتيك', name_en: 'Burger Boutique',
    description_ar: 'برجر فاخر من لحم البقر الطازج 100% مع خبز بريوش محلي الصنع وصلصات حرفية.',
    description_en: 'Premium burgers from 100% fresh beef, locally baked brioche buns, and artisan sauces.',
    address_ar: 'شارع العروبة، الرياض', address_en: 'Al Oruba Street, Riyadh',
    latitude: 24.7250, longitude: 46.6610, phone: '+966112345681', website: 'https://burgerboutique.com.sa',
    rating: 4.5, review_count: 2100, price_level: 3, is_active: 1,
    created_at: '2018-06-01T00:00:00Z', updated_at: '2024-05-20T10:00:00Z',
    categories: [8, 1],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '11:00', close_time: '01:00', is_closed: 0 }))
      .concat([4,5].map(d => ({ day_of_week: d, open_time: '11:00', close_time: '02:00', is_closed: 0 })))
      .concat([{ day_of_week: 6, open_time: '11:00', close_time: '01:00', is_closed: 0 }]),
    images: [
      { url: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800', is_primary: 1, sort_order: 0 },
      { url: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800', is_primary: 0, sort_order: 1 },
    ],
    social_links: [
      { platform: 'instagram', url: 'https://instagram.com/burgerboutique' },
      { platform: 'snapchat',  url: 'https://snapchat.com/add/burgerboutique' },
    ],
  },
  {
    id: 5, name_ar: 'صيدلية النهدي', name_en: 'Nahdi Pharmacy',
    description_ar: 'أكبر سلسلة صيدليات في المملكة، تقدم الأدوية والمستلزمات الطبية والمنتجات الصحية.',
    description_en: "Saudi Arabia's largest pharmacy chain, offering medicines, medical supplies, and health products.",
    address_ar: 'طريق الملك عبدالله، الرياض', address_en: 'King Abdullah Road, Riyadh',
    latitude: 24.7050, longitude: 46.6900, phone: '+966112345682', website: 'https://nahdi.sa',
    rating: 4.3, review_count: 1500, price_level: 2, is_active: 1,
    created_at: '2015-01-01T00:00:00Z', updated_at: '2024-06-15T10:00:00Z',
    categories: [4],
    working_hours: [0,1,2,3,4,5,6].map(d => ({ day_of_week: d, open_time: '08:00', close_time: '00:00', is_closed: 0 })),
    images: [{ url: 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=800', is_primary: 1, sort_order: 0 }],
    social_links: [{ platform: 'twitter', url: 'https://twitter.com/nahdipharmacy' }],
  },
  {
    id: 6, name_ar: 'مخبز بول', name_en: 'Paul Bakery',
    description_ar: 'مخبز وكافيه فرنسي أصيل يقدم الخبز الطازج والمعجنات والحلويات مع قهوة مميزة.',
    description_en: 'Authentic French bakery and café serving fresh bread, pastries, and desserts with premium coffee.',
    address_ar: 'مول العرب، الرياض', address_en: 'Mall of Arabia, Riyadh',
    latitude: 24.7350, longitude: 46.7050, phone: '+966112345683', website: 'https://paul-arabia.com',
    rating: 4.6, review_count: 760, price_level: 3, is_active: 1,
    created_at: '2017-09-01T00:00:00Z', updated_at: '2024-06-08T10:00:00Z',
    categories: [3, 2],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '07:00', close_time: '23:00', is_closed: 0 }))
      .concat([{ day_of_week: 4, open_time: '07:00', close_time: '00:00', is_closed: 0 }])
      .concat([{ day_of_week: 5, open_time: '08:00', close_time: '00:00', is_closed: 0 }])
      .concat([{ day_of_week: 6, open_time: '07:00', close_time: '23:00', is_closed: 0 }]),
    images: [
      { url: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800', is_primary: 1, sort_order: 0 },
      { url: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=800', is_primary: 0, sort_order: 1 },
    ],
    social_links: [{ platform: 'instagram', url: 'https://instagram.com/paulbakeryarabia' }],
  },
  {
    id: 7, name_ar: 'مطعم كيتشن كليف', name_en: 'Kitchen Cliff',
    description_ar: 'مطعم إيطالي راقٍ يقدم البيتزا والمعكرونة المطبوخة على الحطب في أجواء رومانسية.',
    description_en: 'Upscale Italian restaurant serving wood-fired pizza and fresh pasta in a romantic atmosphere.',
    address_ar: 'حي الورود، الرياض', address_en: 'Al Wurud District, Riyadh',
    latitude: 24.7000, longitude: 46.6720, phone: '+966112345684', website: 'https://kitchencliff.sa',
    rating: 4.6, review_count: 540, price_level: 4, is_active: 1,
    created_at: '2022-01-10T00:00:00Z', updated_at: '2024-06-12T10:00:00Z',
    categories: [7, 1],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '13:00', close_time: '23:30', is_closed: 0 }))
      .concat([4,5].map(d => ({ day_of_week: d, open_time: '13:00', close_time: '00:30', is_closed: 0 })))
      .concat([{ day_of_week: 6, open_time: '13:00', close_time: '23:30', is_closed: 0 }]),
    images: [
      { url: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800', is_primary: 1, sort_order: 0 },
      { url: 'https://images.unsplash.com/photo-1548365328-8c6db3220e4c?w=800', is_primary: 0, sort_order: 1 },
    ],
    social_links: [{ platform: 'instagram', url: 'https://instagram.com/kitchencliff' }],
  },
  {
    id: 8, name_ar: 'مطعم المندي والمعصوب', name_en: 'Al Mandi Wa Al Maasub',
    description_ar: 'أصيل المأكولات العربية اليمنية: مندي الدجاج والخروف المطبوخ على الفحم بالطريقة التقليدية.',
    description_en: 'Authentic Yemeni-Saudi cuisine: chicken and lamb mandi slow-cooked over charcoal the traditional way.',
    address_ar: 'حي السليمانية، الرياض', address_en: 'Al Sulimaniyah District, Riyadh',
    latitude: 24.6850, longitude: 46.6950, phone: '+966112345685', website: null,
    rating: 4.9, review_count: 4200, price_level: 2, is_active: 1,
    created_at: '2010-04-01T00:00:00Z', updated_at: '2024-06-18T10:00:00Z',
    categories: [10, 1],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '11:00', close_time: '23:00', is_closed: 0 }))
      .concat([4,5].map(d => ({ day_of_week: d, open_time: '11:00', close_time: '00:00', is_closed: 0 })))
      .concat([{ day_of_week: 6, open_time: '11:00', close_time: '23:00', is_closed: 0 }]),
    images: [{ url: 'https://images.unsplash.com/photo-1519984388953-d2406bc725e1?w=800', is_primary: 1, sort_order: 0 }],
    social_links: [],
  },
  {
    id: 9, name_ar: 'لولو هايبرماركت', name_en: 'LuLu Hypermarket',
    description_ar: 'هايبرماركت ضخم يوفر كل احتياجاتك من البقالة والإلكترونيات والملابس بأسعار تنافسية.',
    description_en: 'Massive hypermarket providing all your grocery, electronics, and clothing needs at competitive prices.',
    address_ar: 'طريق الدائري الشمالي، الرياض', address_en: 'Northern Ring Road, Riyadh',
    latitude: 24.7500, longitude: 46.7200, phone: '+966112345686', website: 'https://luluhypermarket.com',
    rating: 4.2, review_count: 6000, price_level: 2, is_active: 1,
    created_at: '2012-01-01T00:00:00Z', updated_at: '2024-06-01T10:00:00Z',
    categories: [5],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '08:00', close_time: '00:00', is_closed: 0 }))
      .concat([4,5].map(d => ({ day_of_week: d, open_time: '08:00', close_time: '01:00', is_closed: 0 })))
      .concat([{ day_of_week: 6, open_time: '08:00', close_time: '00:00', is_closed: 0 }]),
    images: [{ url: 'https://images.unsplash.com/photo-1588964895597-cfccd6e2dbf9?w=800', is_primary: 1, sort_order: 0 }],
    social_links: [{ platform: 'instagram', url: 'https://instagram.com/luluksa' }],
  },
  {
    id: 10, name_ar: 'مطعم البيت الهندي', name_en: 'Indian Home Restaurant',
    description_ar: 'مطعم هندي أصيل يقدم الكاري والبيريانيات والتندوري بتوابل مستوردة مباشرة من الهند.',
    description_en: 'Authentic Indian restaurant offering curries, biryanis and tandoori with spices imported directly from India.',
    address_ar: 'حي البطحاء، الرياض', address_en: 'Al Batha District, Riyadh',
    latitude: 24.6780, longitude: 46.7100, phone: '+966112345687', website: null,
    rating: 4.5, review_count: 1200, price_level: 2, is_active: 1,
    created_at: '2016-08-01T00:00:00Z', updated_at: '2024-05-30T10:00:00Z',
    categories: [9, 1],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '11:00', close_time: '00:00', is_closed: 0 }))
      .concat([4,5].map(d => ({ day_of_week: d, open_time: '11:00', close_time: '01:00', is_closed: 0 })))
      .concat([{ day_of_week: 6, open_time: '11:00', close_time: '00:00', is_closed: 0 }]),
    images: [
      { url: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800', is_primary: 1, sort_order: 0 },
      { url: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800', is_primary: 0, sort_order: 1 },
    ],
    social_links: [],
  },
  {
    id: 11, name_ar: 'كافيه لطيفة', name_en: 'Café Latifa',
    description_ar: 'مقهى نسائي أنيق يقدم مشروبات القهوة المتخصصة والعصائر الطازجة وحلويات منزلية الصنع.',
    description_en: "Elegant ladies' café serving specialty coffee drinks, fresh juices, and homemade desserts.",
    address_ar: 'حي النزهة، الرياض', address_en: 'Al Nuzha District, Riyadh',
    latitude: 24.7300, longitude: 46.6500, phone: '+966112345688', website: 'https://cafelatifa.sa',
    rating: 4.7, review_count: 430, price_level: 3, is_active: 1,
    created_at: '2023-02-14T00:00:00Z', updated_at: '2024-06-20T10:00:00Z',
    categories: [2, 3],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '09:00', close_time: '23:00', is_closed: 0 }))
      .concat([4,5].map(d => ({ day_of_week: d, open_time: d===5?'10:00':'09:00', close_time: '00:00', is_closed: 0 })))
      .concat([{ day_of_week: 6, open_time: '09:00', close_time: '23:00', is_closed: 0 }]),
    images: [{ url: 'https://images.unsplash.com/photo-1600093463592-8e36ae95ef56?w=800', is_primary: 1, sort_order: 0 }],
    social_links: [{ platform: 'instagram', url: 'https://instagram.com/cafelatifa.sa' }],
  },
  {
    id: 12, name_ar: 'مطعم شاورما الشام', name_en: 'Al Sham Shawarma',
    description_ar: 'شاورما سورية أصيلة محضرة يومياً من لحم الدجاج والغنم المتبل بالبهارات الشامية.',
    description_en: 'Authentic Syrian shawarma prepared daily from chicken and lamb marinated in Levantine spices.',
    address_ar: 'شارع الأمير سلطان، الرياض', address_en: 'Prince Sultan Street, Riyadh',
    latitude: 24.6950, longitude: 46.6820, phone: '+966112345689', website: null,
    rating: 4.8, review_count: 3800, price_level: 1, is_active: 1,
    created_at: '2008-01-01T00:00:00Z', updated_at: '2024-06-05T10:00:00Z',
    categories: [10, 1],
    working_hours: [0,1,2,3].map(d => ({ day_of_week: d, open_time: '09:00', close_time: '02:00', is_closed: 0 }))
      .concat([4,5].map(d => ({ day_of_week: d, open_time: '09:00', close_time: '03:00', is_closed: 0 })))
      .concat([{ day_of_week: 6, open_time: '09:00', close_time: '02:00', is_closed: 0 }]),
    images: [{ url: 'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800', is_primary: 1, sort_order: 0 }],
    social_links: [],
  },
];

// ── Run seed ──────────────────────────────────────────────────────────────────
function seed() {
  const db = getDb();

  const insertCat = db.prepare(
    'INSERT OR REPLACE INTO categories (id, name_ar, name_en, icon) VALUES (@id, @name_ar, @name_en, @icon)'
  );
  const insertPlace = db.prepare(`
    INSERT OR REPLACE INTO places
      (id,name_ar,name_en,description_ar,description_en,address_ar,address_en,
       latitude,longitude,phone,website,rating,review_count,price_level,is_active,created_at,updated_at)
    VALUES
      (@id,@name_ar,@name_en,@description_ar,@description_en,@address_ar,@address_en,
       @latitude,@longitude,@phone,@website,@rating,@review_count,@price_level,@is_active,@created_at,@updated_at)
  `);
  const insertPC   = db.prepare('INSERT OR IGNORE INTO place_categories (place_id, category_id) VALUES (?, ?)');
  const insertWH   = db.prepare(`
    INSERT OR REPLACE INTO working_hours (place_id,day_of_week,open_time,close_time,is_closed)
    VALUES (@place_id,@day_of_week,@open_time,@close_time,@is_closed)
  `);
  const insertImg  = db.prepare(`
    INSERT INTO place_images (place_id,url,is_primary,sort_order)
    VALUES (@place_id,@url,@is_primary,@sort_order)
  `);
  const insertSL   = db.prepare('INSERT INTO social_links (place_id,platform,url) VALUES (@place_id,@platform,@url)');

  const clearImages  = db.prepare('DELETE FROM place_images  WHERE place_id = ?');
  const clearLinks   = db.prepare('DELETE FROM social_links  WHERE place_id = ?');

  const runAll = db.transaction(() => {
    // Categories
    for (const c of categories) insertCat.run(c);

    // Places + relations
    for (const p of places) {
      const { categories: cats, working_hours: whs, images, social_links: links, ...row } = p;
      insertPlace.run(row);

      for (const catId of cats)  insertPC.run(p.id, catId);
      for (const wh of whs)      insertWH.run({ ...wh, place_id: p.id });
      clearImages.run(p.id);
      for (const img of images)  insertImg.run({ ...img, place_id: p.id });
      clearLinks.run(p.id);
      for (const sl of links)    insertSL.run({ ...sl, place_id: p.id });
    }
  });

  runAll();
  console.log(`✅  Seeded ${categories.length} categories and ${places.length} places.`);
  db.close();
}

seed();
