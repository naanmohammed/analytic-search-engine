# db/seeds.rb

# Clear existing data
Article.destroy_all

# Seed articles
articles_data = [
  { title: "The Art of Programming", content: "In this article, we explore the intricacies of software development and the creative aspects of programming." },
  { title: "Ruby on Rails Basics", content: "A comprehensive guide to Ruby on Rails basics, covering models, views, controllers, and more." },
  { title: "Data Science and Machine Learning", content: "An overview of data science and machine learning, discussing key concepts and applications in various industries." },
  { title: "Web Development Trends 2023", content: "Stay updated with the latest trends in web development for the year 2023. From new frameworks to design principles, we've got you covered." },
  { title: "The Future of Artificial Intelligence", content: "Examining the potential advancements and impact of artificial intelligence on society, businesses, and everyday life." },
  { title: "JavaScript Frameworks Comparison", content: "A detailed comparison of popular JavaScript frameworks, including React, Vue, and Angular, to help you choose the right one for your project." },
  { title: "Building Scalable Microservices", content: "Learn best practices for designing and building scalable microservices architectures to meet the demands of modern applications." },
  { title: "Cybersecurity Essentials", content: "Understanding the essential concepts of cybersecurity and implementing measures to protect your digital assets from potential threats." },
  { title: "The Evolution of Mobile App Development", content: "Trace the evolution of mobile app development from early days to the current trends, exploring technologies and design principles." },
  { title: "Introduction to Quantum Computing", content: "An introductory article on quantum computing, delving into the principles of quantum mechanics and its applications in computing." },
  { title: "Databases: SQL vs. NoSQL", content: "Comparing SQL and NoSQL databases, their strengths, and use cases to help you make informed decisions in database design." },
  { title: "Responsive Web Design Techniques", content: "Explore the techniques and best practices for creating responsive web designs that adapt seamlessly to various screen sizes." },
  { title: "The Rise of DevOps Culture", content: "Examining the rise of DevOps culture, its principles, and how it transforms the collaboration between development and operations teams." },
  { title: "Cloud Computing Advantages", content: "Understanding the advantages of cloud computing, from scalability to cost efficiency, and how businesses leverage cloud services." },
  { title: "User Experience Design Fundamentals", content: "A guide to the fundamentals of user experience (UX) design, focusing on creating intuitive and delightful digital experiences." },
  { title: "Python for Data Analysis", content: "An in-depth look at using Python for data analysis, covering libraries like Pandas and NumPy for efficient data manipulation." },
  { title: "Blockchain Technology Explained", content: "Demystifying blockchain technology and its applications beyond cryptocurrency, including smart contracts and decentralized applications." },
  { title: "Agile Project Management Practices", content: "Explore agile project management practices, from sprint planning to continuous improvement, for delivering successful software projects." },
  { title: "Social Media Marketing Strategies", content: "Effective social media marketing strategies to boost your brand's online presence, engage with your audience, and drive business growth." },
  { title: "The Importance of Code Reviews", content: "Highlighting the importance of code reviews in software development, including best practices and their impact on code quality." }
]

articles_data.each do |article_data|
  Article.create!(article_data)
end

puts "Seeding completed!"
