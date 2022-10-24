module.exports = {
  apps: [
    {
      name: 'nestjs-circleci',
      script: './dist/main.js',
      cwd: '.',
    },
  ],
};
